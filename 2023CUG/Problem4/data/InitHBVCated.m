clc;clear;close all;
load rawHBVCatedData.mat
%% 填充缺失值
varnum=size(HBVData,2);
for i=1:varnum
    tmp=table2array(HBVData(:,i));
    indNan=find(isnan(tmp));
    HBVData(indNan,i)=array2table(mean(rmmissing(tmp)));
end
clear i tmp varnum indNan
%% 数据正向化
HBVData.AG=HBVData.ALB./HBVData.GLB;
HBVData.ALB=[];HBVData.GLB=[];
HBVData.AG=abs(HBVData.AG-2);
HBVData.RBC=max(HBVData.RBC)-HBVData.RBC;
HBVData.EBC=max(HBVData.EBC)-HBVData.EBC;
HBVData.PLT=max(HBVData.PLT)-HBVData.PLT;
HBVData.HDL_C=max(HBVData.HDL_C)-HBVData.HDL_C;
%% 计算与血糖相关性
GLU=HBVData.GLU;Sex=HBVData.Sex;Age=HBVData.Age;%血糖
HBVData.GLU=[];HBVData.Sex=[];HBVData.Age=[];
indSick=[find(GLU>6.1);find(GLU<3.1)];
cateSick=zeros(length(HBVind),1);
cateSick(indSick)=1;%标记异常值

varlen=size(HBVData,2);
seq=table2array(HBVData);%属于连续值的指标
seqnum=size(seq,2);
R=zeros(1,seqnum);P=zeros(1,seqnum);
for i=1:seqnum                      %计算每个连续值的指标与血糖间的相关性
    [tmpR,tmpP]=corrcoef(seq(:,i),GLU);
    R(i)=tmpR(1,2);P(i)=tmpP(1,2);
end
clear i tmpR tmpP varlen
%% 切分显著指标与不显著指标
significantInd=find(P<=0.01);
significantSeq=seq(:,significantInd);
unsignificantInd=find(P>0.01);
unsignificantSeq=seq(:,unsignificantInd);
HBVData=HBVData(:,unsignificantInd);
t=table(Sex,Age,cateSick);
HBVData=[t,HBVData];%将非数值数据放回
writetable(HBVData,'HBVData.xlsx');
clear t
%%

save HBVCatedData.mat