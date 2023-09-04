clc;clear;close all;
load Series.mat
weightEdge=zeros(1049,8);%8个指标
weightNode=zeros(81,12);%12个指标
for edge=1:num_connect
    weightEdge(edge,:)=MeasureEdge(edge,Time_start,Time_end,Time_var);
end
for i=1:8
    weightEdge(:,i)=zscore(weightEdge(:,i));
end
weightEdge(:,8)=-weightEdge(:,8);%历史最长流量不存在天数是极小指标
indEdge_clean=find(weightEdge(1,:));
tmp=weightEdge(:,indEdge_clean);
weightEdge=[];
weightEdge=tmp;
clear i edge tmp
for node=1:num
    weightNode(node,:)=MeasureNode(node,Time_start,Time_end,Time_var);
end
for i=1:12
    weightNode(:,i)=zscore(weightNode(:,i));
end
indNode_clean=find(weightNode(1,:));
tmp=weightNode(:,indNode_clean);
weightNode=[];
weightNode=tmp;
clear i node tmp
save("Weight.mat","weightEdge","weightNode");
writematrix(weightNode,"Weight.xlsx",Sheet=1);
writematrix(weightEdge,"Weight.xlsx",Sheet=2);