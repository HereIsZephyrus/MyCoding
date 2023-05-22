clc;clear;close all;
load originElevator.mat

%{
axis([0,max(Time)+1,min(Pressure)-0.5,max(Pressure)+0.5]);
grid on;
title("教三楼下降气压随时间变化(原始数据)");
xlabel("时间(s)");
ylabel("气压(hPa)");
%}

hold on
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
Altitude=Altitude+40;
%Altitude=Altitude-min(Altitude)+1;
clear Begin End Len

% fit
tbl=table(Altitude, Pressure ,'VariableNames',{'Altitude','Pressure'});
mdl = fitlm(tbl);
p=plot(mdl);
p(1).Color='blue';
fitEast=table2array(mdl.Coefficients);
fitEast=fitEast(:,1);
clear tbl mdl p

%% Third2
% clear Data
Len=size(Third2,1);
Begin=42;End=Len-3;
Time=Third2(Begin:End,"Times");
Time=table2array(Time);
Time=Time-Begin+1;
Pressure=Third2(Begin:End,"PressurehPa");
Pressure=table2array(Pressure);
Altitude=Third2(Begin:End,"Altitudem");
Altitude=table2array(Altitude);
Altitude=Altitude+40;
%Altitude=Altitude-min(Altitude)+1;
clear Begin End Len

% fit
tbl=table(Altitude, Pressure ,'VariableNames',{'Altitude','Pressure'});
mdl = fitlm(tbl);
p=plot(mdl);
p(1).Color='magenta';
fitThird=table2array(mdl.Coefficients);
fitThird=fitThird(:,1);
clear tbl mdl p

%% Second2
% clear Data
Len=size(Second2,1);
Begin=35;End=Len-2;
Time=Second2(Begin:End,"Times");
Time=table2array(Time);
Time=Time-Begin+1;
Pressure=Second2(Begin:End,"PressurehPa");
Pressure=table2array(Pressure);
Altitude=Second2(Begin:End,"Altitudem");
Altitude=table2array(Altitude);
Altitude=Altitude+40;
%Altitude=Altitude-min(Altitude)+1;
clear Begin End Len

% fit
tbl=table(Altitude, Pressure ,'VariableNames',{'Altitude','Pressure'});
mdl = fitlm(tbl);
p=plot(mdl);
p(1).Color=[0.8500 0.3250 0.0980];
fitSecond=table2array(mdl.Coefficients);
fitSecond=fitSecond(:,1);
clear tbl mdl p

%%
%axis([0,15,998,1002]);
grid on
legend(strcat("东区教学楼k=",num2str(fitEast(2))),"","","",strcat("教三楼k=",num2str(fitThird(2))),"","","",strcat("教二楼k=",num2str(fitSecond(2))),"","","");
hold off

clear Time Altitude Pressure
