clc;clear;close all;
load arrayData.mat
labels={'母亲年龄','婚姻状况','教育水平','妊娠时间','生产方式','CBTS','EPDS','HADS','行为特征','睡眠时间','睡醒次数','入睡方式'};
h = heatmap(labels,labels, R, 'FontSize',8, 'FontName','Helvetica');
h.FontSize=14;
h.Title='各原始数据与婴儿行为和睡眠的相关性系数';
h.CellLabelColor = 'auto';
set(gcf,'Color',[1 1 1]);