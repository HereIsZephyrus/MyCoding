%clc;clear;close all;
function [weightNode,weightEdge]=Weight(start,term,value)
weightEdge=zeros(1049,8);%8个指标
weightNode=zeros(81,12);%12个指标
for edge=1:num_connect
    weightEdge(edge,:)=MeasureEdge(edge,start,term,value);
end
for i=1:8
    weightEdge(:,i)=zscore(weightEdge(:,i));
end
weightEdge(:,8)=-weightEdge(:,8);%历史最长流量不存在天数是极小指标
indEdge_clean=find(weightEdge(1,:));
tmp=weightEdge(indEdge_clean,:);
weightEdge=[];
weightEdge=tmp;
clear i edge tmp
for node=1:num
    weightNode(node,:)=MeasureNode(node,start,term,value);
end
for i=1:12
    weightNode(:,i)=zscore(weightNode(:,i));
end
indNode_clean=find(weightNode(1,:));
tmp=weightNode(indNode_clean,:);
weightNode=[];
weightNode=tmp;
clear i node tmp
end