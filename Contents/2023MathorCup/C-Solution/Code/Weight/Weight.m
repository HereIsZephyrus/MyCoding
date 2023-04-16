clc;clear;close all;
load Series.mat
%delete(gcp('nocreate'));
%p=parpool(12);
weightEdge=zeros(1049,8);%8个指标
weightNode=zeros(81,12);%12个指标
for edge=1:num_connect
    weightEdge(edge,:)=MeasureEdge(edge,Time_start,Time_end,Time_var);
end
for i=1:8
    weightEdge(:,i)=zscore(weightEdge(:,i));
end
weightEdge(:,8)=-weightEdge(:,8);%历史最长流量不存在天数是极小指标
clear i edge
for node=1:num
    weightNode(node,:)=MeasureNode(node,Time_start,Time_end,Time_var);
end
for i=1:12
    weightNode(:,i)=zscore(weightNode(:,i));
end
clear i node
save("Weight.mat","weightEdge","weightNode");
writematrix(weightNode,"Weight.xlsx",Sheet=1);
writematrix(weightEdge,"Weight.xlsx",Sheet=2);