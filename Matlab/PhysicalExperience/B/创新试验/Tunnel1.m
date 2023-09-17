clc;clear;close all;
load originTunnel.mat
%% 阴天
Time1=CloudWalk1(:,"Times");
Time1=table2array(Time1);
Pressure1=CloudWalk1(:,"PressurehPa");
Pressure1=table2array(Pressure1);

%% 雨天
hold on
Time2=RainWalk2(:,"Times");
Time2=table2array(Time2);
Pressure2=RainWalk2(:,"PressurehPa");
Pressure2=table2array(Pressure2);
%%
plot(Time1,Pressure1);
plot(Time2,Pressure2);
legend("阴天","雨天");
b = brush;
b.Enable = 'on';
b.Color = 'green';
grid on
xlabel("记录时间(s)");
ylabel("气压变化(hPa)");
title("不同天气步行通过隧道气压变化对比");
axis([50 300 min(Pressure2)-0.1 max(Pressure1)+0.1]);
hold off