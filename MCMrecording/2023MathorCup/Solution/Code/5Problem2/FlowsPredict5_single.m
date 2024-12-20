clc;clear;close all;
load FlowsAmong5.mat
load cateNode5.mat
load Series.mat
load PredictFlows5.mat
%预测DC5附近的流量
nearFlows=Flows(:,365*2-61+1:365*2);

len_pre=31;%预测长度
%%
cate=1;
i=42;
edge=E{cate}(i);
Data=Time_var(edge,365*2-61+1:365*2);
Data=filloutliers(Data,"linear");
len=length(Data);
tmp_data=Data;
len_block=40;%滑块长度
for j=1:len_pre
   len=len+1;
   tmp_data(len)=Average(tmp_data,len_block);
end
PredictFlows{cate}(i,:)=tmp_data(len-len_pre+1:len);
clear len a b edge
%%
cate=3;
s=[86,209,344,122,89,123,57,381,11,85,87,322,145,117,23,86,68];
for j=1:length(s)
    i=s(j);
edge=E{cate}(i);
Data=Time_var(edge,365*2-61+1:365*2);
Data=filloutliers(Data,"linear");
len=length(Data);
tmp_data=Data;
len_block=40;%滑块长度
for j=1:len_pre
   len=len+1;
   tmp_data(len)=Average(tmp_data,len_block);
end
PredictFlows{cate}(i,:)=tmp_data(len-len_pre+1:len);
clear len a b edge
end
%%
cate=4;
s=[159,128,93,94,86,26,75];
for j=1:length(s)
    i=s(j);
edge=E{cate}(i);
Data=Time_var(edge,365*2-61+1:365*2);
Data=filloutliers(Data,"linear");
len=length(Data);
tmp_data=Data;
len_block=40;%滑块长度
for j=1:len_pre
   len=len+1;
   tmp_data(len)=Average(tmp_data,len_block);
end
PredictFlows{cate}(i,:)=tmp_data(len-len_pre+1:len);
clear len a b edge
end
%%
save("PredictFlows5.mat","PredictFlows");
clear ans

function y_pre=Average(y,n)
    m=length(y);
    y_pre=sum( y(m-n+1:m) ) / n;
end