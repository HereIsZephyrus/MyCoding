%clc;clear;close all;
load slopeUrban.mat

multi = 1;
count15=smoothdata(count15c,'loess');
count17=smoothdata(count17c,'loess');
count19=smoothdata(count19c,'loess');
%plot(f15,slope,count15);
plot(slop,count15*multi,'LineWidth',1.5);
hold on
%plot(f17,slope,count17);
%plot(f19,slope,count19);
plot(slop,count17*multi,'LineWidth',1.5);
plot(slop,count19*multi,'LineWidth',1.5);
legend("2015农业农地坡谱","2017农业农地坡谱","2019农业农地坡谱",fontsize=14);
title("各年农业农地坡度谱线",fontsize = 18);
hold off

zp = BaseZoom();
zp.plot;