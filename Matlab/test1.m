clc;clear all;close all;
Test_Handle=@cos
x=linspace(-pi,pi,50);
y=2*x;
Replace=Test_Handle(x,y)
figure;
plot(Replace,'b')