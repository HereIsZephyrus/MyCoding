clc;clear;close all;
load FlowsAmong9total.mat
load cateNode9total.mat
load Series.mat
%预测DC9附近的流量
%delete(gcp('nocreate'));
%p=parpool(12);
nearFlows=Flows(:,365*2-61+1:365*2);

clear i
len_pre=31;%预测长度
err=zeros(1,4);
Predict=cell(1,4);
for cate=1:4
    for i=1:length(E{cate})
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
        Predict{cate}(i,:)=tmp_data(len-len_pre+1:len);
        clear len a b edge
    end
end
PredictFlows=Predict;
clear Predict
save("PredictFlows9total.mat","PredictFlows");
%delete(p);
clear ans

function y_pre=Average(y,n)
    m=length(y);
    y_pre=sum( y(m-n+1:m) ) / n;
end