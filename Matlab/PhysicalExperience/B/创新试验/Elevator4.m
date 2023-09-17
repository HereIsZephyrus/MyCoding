clc;clear;close all;
load originElevator.mat
%% 高度
% clear Data
Time1=EastH(:,"Times");
Time1=table2array(Time1);
Pressure1=EastH(:,"PressurehPa");
Pressure1=table2array(Pressure1);
Altitude1=EastH(:,"Altitudem");
Altitude1=table2array(Altitude1);
Velocity1=EastH(:,"Velocityms");
Velocity1=table2array(Velocity1);
bias1=1.2;
ind1=find(Velocity1>=bias1);
Time1=Time1(ind1);
Time1=Time1-min(Time1);
Pressure1=Pressure1(ind1);
Pressure1=flip(Pressure1);
Altitude1=Altitude1(ind1);
Velocity1=Velocity1(ind1);

%% 
fig=figure(1);
plot(Altitude1,Pressure1,'r.-');
grid on
xlabel("海拔");
ylabel("气压");
title("东区综合教学楼从底面至顶层阳台高度数据");
t=text(30,1007,strcat("高度差为",num2str(round(max(Altitude1)*100-min(Altitude1)*100)/100),"m"));
t.FontSize=18;
t=text(30,1006,strcat("层高约为",num2str(round(max(Altitude1)-min(Altitude1))/17),"m"));
t.FontSize=18;