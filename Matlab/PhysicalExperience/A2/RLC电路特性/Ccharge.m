clc;clear;close all;
C=0.1e-6;
R=[10e3,20e3,40e3];
dV_half=[3.70,3.40,2.44];
t=[700e-6,1.3e-3,2.1e-3];
subplot(1,2,1);
hold on
xlabel("电容两端电压下降1/2使用的时间t/s");
ylabel("串联电路电阻R/ \Omega");
title("RC电路放电时间与电阻函数(C固定)");
plot(t,R,'b*-');
subplot(1,2,2);
tt=linspace(min(t),max(t),100);
vv=spline(t,dV_half,tt);
plot(tt,vv*2,'g-');
xlabel("电容两端电压下降1/2使用的时间t/s");
ylabel("电阻两端电压/ V");
title("RC电路放电时间与电容两端电压函数(C固定)");
hold off

