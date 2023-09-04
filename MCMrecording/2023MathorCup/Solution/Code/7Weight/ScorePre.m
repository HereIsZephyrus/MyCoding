clc;clear;close all;
load Weight.mat
load Series.mat
[scoreNode,scoreEdge]=Score(weightNode,weightEdge);
Node=1:81;
Edge=1:1049;
tblNode=table(Node',scoreNode');
tblEdge=table(Edge',Time_start,Time_end,scoreEdge');
writetable(tblNode,"Score.xlsx",'sheet',1);
writetable(tblEdge,"Score.xlsx",'sheet',2);