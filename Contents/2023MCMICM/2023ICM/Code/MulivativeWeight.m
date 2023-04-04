%对影响申办国申办意愿的各个因素进行多元分析,得出每一类国家的权重
clc;clear;close all;
load volunteeringSummer.mat
load clusterSummer.mat
load HostsScoreSummer.mat

[years,cates]=size(Volunteering_clustered);

for Cate=1:cates
    for time=1:years
        [Weight,stats]=Factor_2023ICM(Contribution{time,Cate},Volunteering_clustered(time,Cate),5);
    end
end