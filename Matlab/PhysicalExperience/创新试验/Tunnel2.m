clc;clear;close all;
load originTunnel.mat
%% 下坡
Time1=SunCycle1(:,"Times");
Time1=table2array(Time1);
Pressure1=SunCycle1(:,"PressurehPa");
Pressure1=table2array(Pressure1);

%% 上坡
hold on
Time2=SunCycle2(:,"Times");
Time2=table2array(Time2);
Pressure2=SunCycle2(:,"PressurehPa");
Pressure2=table2array(Pressure2);
%%
plot(Time1,Pressure1);
plot(Time2,Pressure2);
legend("北区->西区:2点半","西区->北区:12点半","Location","east");
b = brush;
b.Enable = 'on';
b.Color = 'green';
grid on
xlabel("记录时间(s)");
ylabel("气压变化(hPa)");
title("同一天不同时间骑行通过隧道气压变化对比");
axis([5 170 min(Pressure2)-0.1 max(Pressure1)+0.1]);
hold off