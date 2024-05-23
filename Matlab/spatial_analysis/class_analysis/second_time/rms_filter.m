clc;clear;close all;
dpi = 300;
width = 1300;
height = 600;
figure;
position = [100, 100, width, height];
set(gcf, 'Position', position);
%% class1
load adj_class1.mat
subplot(1,2,1);
res = rms(dis,2);
cdfplot(res);
xlabel("每人连接强度的RMS",FontSize=14);
ylabel("CDF",FontSize=14);
title("114221/114222/220221-2空间权重矩阵RMS累计分布",FontSize=18);
clear dis;
%% class2
load adj_class2.mat
subplot(1,2,2);
res = rms(dis,2);
cdfplot(res);
xlabel("每人连接强度的RMS",FontSize=14);
ylabel("CDF",FontSize=14);
title("114223空间权重矩阵RMS累计分布",FontSize=18);

%print(gcf, '-dpng', sprintf('-r%d', dpi), 'RMS_CDF.png');