clc;clear;close all;

X0=43.5:1:60.5;
I0=[4.47e-5 3.75e-5 1.97e-5 0.44e-5 71.6e-8 104.9e-8 98.9e-8 46.7e-8 24.5e-8 25e-8 23e-8 17.6e-8 10.8e-8 9.2e-8 11.0e-8 7.8e-8 4.2e-8 4.9e-8];
X=26.5:60.5;
I=[I0(length(I0):-1:2) I0];
XX=linspace(min(X),max(X),1000);
Ihat0=spline(X,I,XX);

pairX=[43.7,49.3,52.4,57.5,61.5];
pairI=[4.42e-5,0.12e-5,25e-8,11e-8,6.5e-8];
subplot(1,2,1);
plot(X,I,'bo');
hold on
plot(pairX,pairI,'m*');
plot(XX,Ihat0,'g-');
title("夫琅禾费单缝衍射光强分布曲线");
legend("测量数据","峰值(单侧)","拟合数据");
hold off

subplot(1,2,2);
semilogy(X,I,'bo');
hold on
semilogy(pairX,pairI,'m*');
semilogy(XX,Ihat0,'g-');
hold off
title("夫琅禾费单缝衍射光强分布对数曲线");
legend("测量数据","峰值(单侧)","拟合数据");
