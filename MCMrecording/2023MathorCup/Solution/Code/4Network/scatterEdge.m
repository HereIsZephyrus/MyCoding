clc;clear;close all;
%对DC5的相邻节点做分类
%delete(gcp('nocreate'));
load Series.mat
%p=parpool(12);
startTime=min(find(Date==datetime(2022,12,1)));
%% clear
%delete(p);
clear ans