clc;clear;close all;
%对DC5的相邻节点做分类
%delete(gcp('nocreate'));
load Series.mat
load cate.mat
%p=parpool(12);

Normal_edge=[Count{1},Count{3},Count{6},Count{7}];
N=cell(1,4);
E=cell(1,4);
%% Node1DC5左节点
%N{1}=Time_start(E{1})';
E{1}=find(Time_end==5)';
E{1}=intersect(E{1},Normal_edge);
N{1}=Time_start(E{1})';
%% Node2DC5右节点
%N{2}=Time_end(E{2})';
E{2}=find(Time_start==5)';
E{2}=intersect(E{2},Normal_edge);
N{2}=Time_start(E{2})';
%% Node3DC5左节点的右节点
N3=[];
for node=1:length(N{1})
    edge=find(Time_start==N{1}(node))';
    edge=intersect(edge,Normal_edge);
    N3=[N3,Time_end(edge)'];
    E{3}=[E{3},edge];
end
N3=N3(N3~=5);
N{3}=unique(N3);
E{3}=find(Time_end(E{3})~=5)';
clear node edge N3

%% Node4DC5右节点的左节点
N4=[];
for node=1:length(N{2})
    edge=find(Time_end==N{2}(node))';
    edge=intersect(edge,Normal_edge);
    N4=[N4,Time_end(edge)'];
    E{4}=[E{4},edge];
end
N4=N4(N4~=5);
N{4}=unique(N4);
E{4}=find(Time_start(E{4})~=5)';
clear node edge N4
%% clear
%delete(p);
save("cateNode5.mat","N","E");
clear ans