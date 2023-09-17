clc;clear;close all;
load originElevator.mat
%% 上升
% clear Data
Time1=Third1(:,"Times");
Time1=table2array(Time1);
Pressure1=Third1(:,"PressurehPa");
Pressure1=table2array(Pressure1);
Altitude1=Third1(:,"Altitudem");
Altitude1=table2array(Altitude1);
Velocity1=Third1(:,"Velocityms");
Velocity1=table2array(Velocity1);
bias1=1.2;
ind1=find(Velocity1>=bias1);
Time1=Time1(ind1);
Time1=Time1-min(Time1);
Pressure1=Pressure1(ind1);
Pressure1=flip(Pressure1);
Altitude1=Altitude1(ind1);
Velocity1=Velocity1(ind1);

%% 下降
% clear Data
Time2=Third2(:,"Times");
Time2=table2array(Time2);
Pressure2=Third2(:,"PressurehPa");
Pressure2=table2array(Pressure2);
Altitude2=Third2(:,"Altitudem");
Altitude2=table2array(Altitude2);
Velocity2=Third2(:,"Velocityms");
Velocity2=table2array(Velocity2);
Velocity2=-Velocity2;
bias2=1.2;
ind2=find(Velocity2>=bias2);
Time2=Time2(ind2);
Time2=Time2-min(Time2);
Pressure2=Pressure2(ind2);
Altitude2=-Altitude2(ind2);
Velocity2=Velocity2(ind2);
%% 
fig=figure(1);
subplot(2,2,1);
hold on
plot(1:length(Time1),Altitude1,'r.-');
plot(1:length(Time2),Altitude2,'b.-');
hold off
xlabel("时间");
ylabel("海拔");
subplot(2,2,2);
hold on
plot(1:length(Time1),Velocity1,'r.');
plot(1:length(Time2),Velocity2,'b.');
hold off
xlabel("时间");
ylabel("速度");
subplot(2,2,3);
hold on
plot(1:length(Time1),Pressure1,'r.-');
plot(1:length(Time2),Pressure2,'b.-');
hold off
xlabel("时间");
ylabel("气压");
subplot(2,2,4);
hold on
plot(Altitude1,Pressure1,'r.-');
plot(Altitude2,Pressure2,'b.-');
hold off
xlabel("海拔");
ylabel("气压");