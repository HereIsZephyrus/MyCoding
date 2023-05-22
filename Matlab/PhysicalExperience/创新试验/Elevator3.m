clc;clear;close all;
load originElevator.mat
%% East2
% clear Data
Len=size(East2,1);
Begin=45;End=Len-5;
Time=East2(Begin:End,"Times");
Time=table2array(Time);
Time=Time-Begin+1;
Pressure=East2(Begin:End,"PressurehPa");
Pressure=table2array(Pressure);
Altitude=East2(Begin:End,"Altitudem");
Altitude=table2array(Altitude);
Altitude=Altitude+41.5;

clear Begin End Len
hold on
plot(Pressure,Altitude,'b.-');
p0=max(Pressure);
H=@(p) -29.240*290*log(p/p0);
bia=sum(H(Pressure)-Altitude)/length(Altitude);
bia=bia/max(Altitude);
disp(bia);
fplot(H,[998 1003]);
legend("测量值","理论值")
%axis([1000,1003]);
grid on;
title("东区综合教学楼下降气压随高度变化");
ylabel("海拔");
xlabel("气压(hPa)");
hold off
clear p