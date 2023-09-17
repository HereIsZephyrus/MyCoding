clc;close all;clear
load('interpolated_depth_data.mat');
%%
rng("shuffle");
x(1)=0.25+rand()*0.05;
eta=0.15;

beta = 86.9037;  % 例如，角度为30度
theta = 120; % 例如，角度为45度

sd=CalcSdL1(x(1),beta,theta,Z);
for i=1:60
    len(i)=CalcLineLen(x(i),beta);
    [A1,A2]=CalcLineArea(x(i),0,len(i),beta,theta,Z);
    dd=(1-eta)*A2/len(i);
    x(i+1)=x(i)+dd*sind(beta);
    [x(i+1),tmpSd,a(i+1),b(i+1)]=FindNextLine(x(i),x(i+1),beta,theta,Z);
    sd=sd+max(0,tmpSd);
    disp(x(i+1));
end