clc;clear;close all;
load rawCatedData.mat
rawCatedData_copy=rawCatedData;
rawCatedData_copy.ID=[];%脱敏数据去掉ID
%% 将日期信息转换为离散数值
date=rawCatedData_copy.Date;%datetime单独考虑
rawCatedData_copy.Date=[];
date=char(date);
month=str2num(date(:,4:5));
%因为所有样本均在9月与10月之间，所以先不考虑了
%% 检验年龄是否为正态分布
age=rawCatedData_copy.Age;
cdf=[age,normcdf(age,9.8225,5.0572)];
isAgeCdf=kstest(age,cdf);
%% 将乙肝患者的样本分离开
K_Be=rawCatedData_copy.K_Be;
HBVind=find(~isnan(K_Be));
HBVData=rawCatedData_copy(HBVind,:);
save HBVCatedData.mat HBVData HBVind
%% 筛选缺失值
[len,rawVar]=size(rawCatedData_copy);
indValued=[];
countNan=zeros(1,rawVar);
for i=1:rawVar%统计每个指标的缺失值数量
    tmp=table2array(rawCatedData_copy(:,i));
    countNan(i)=sum(isnan(tmp));
    indNan=find(isnan(tmp));
    rawCatedData_copy(indNan,i)=array2table(mean(rmmissing(tmp)));
    if (countNan(i)<(len/2))
        indValued=[indValued,i];
    end
end
clear i indNan
catedData=rawCatedData_copy(:,indValued);%先过滤掉缺失值过大的指标
countNan=countNan(indValued);
clear indValued tmp
[countNan,ind]=sort(countNan,'ascend');%对剩下的指标依据缺失值排序
catedData=catedData(:,ind);%处理完成
clear ind rawVar
%% 计算与血糖相关性
glucose=rawCatedData_copy.GLU;%血糖
indSick=[find(glucose>6.1);find(glucose<3.1)];
cateSick=zeros(len,1);
cateSick(indSick)=1;%标记异常值
t=table(cateSick);
catedData=[t,catedData];%将非数值数据放回，这两个没有缺失值不参加排序放前面
clear t
varlen=size(catedData,2);
seq=table2array(catedData(:,5:varlen));%属于连续值的指标
seqnum=size(seq,2);
R=zeros(1,seqnum);P=zeros(1,seqnum);
for i=1:seqnum                      %计算每个连续值的指标与血糖间的相关性
    [tmpR,tmpP]=corrcoef(seq(:,i),glucose);
    R(i)=tmpR(1,2);P(i)=tmpP(1,2);
end
clear i tmpR tmpP
%% 切分显著指标与不显著指标
significantInd=find(P<=0.01);
significantSeq=seq(:,significantInd);
unSignificantInd=find(P>0.01);
unsignificantSeq=seq(:,unSignificantInd);
catedData=catedData(:,[1:4,significantInd+4]);%留在表中的都是显著的连续指标了

%% 输出标准化前结果
rawCatedData_copy=rawCatedData_copy(find(isnan(K_Be)),:);
clear rawCatedData_copy
save catedData.mat catedData countNan isAgeCdf
save catedCorrcoef.mat seq R P significantSeq unsignificantSeq glucose
