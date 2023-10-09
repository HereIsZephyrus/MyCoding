clc;clear;close all;
data=[93.70480,93.72255,93.73920,93.75620,...
    93.77332,93.79050,93.80820,93.82602];
times=1:8;
hold on;
scatter (times,data,'MarkerEdgeColor',[0 .5 .5],...
              'MarkerFaceColor','b',...
              'LineWidth',1);
[p,S] = polyfit(times,data,1);
yfit=polyval(p,1:8);
plot(times,yfit,'g-','LineWidth',1.2);
legend("测量数据","拟合数据",'Location','northwest');
xlabel("测量次数");  ylabel("镜组位置");
title("以50圈干涉条纹为一组的测量结果");
lamda=2*p(1)/50;
L0=632.8;%nm
str={strcat("理论波长\lambda_0=",num2str(L0),"nm"),strcat("实测波长\lambda=",...
    num2str(lamda*1e6),"nm"),strcat("误差    \eta=",num2str((lamda*1e6-L0)/L0))};
text(5,data(3),str);
hold off;