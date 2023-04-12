clc;clear;close all;
load data.mat
load R.mat
Rh=(Rh1+Rh2)/2;
e=1.602176565e-19;
n=3*pi/(8*Rh*e);
Is=3;%mA
dx=50;%mm
B=Vh.*(dx/10)*2/(Rh*Is);

hold on
plot(X,Vh,'b*');
plot(X,B,'r-');
a=polyfit(X,Vh,4);
x=linspace(min(X),max(X),500);
Interp_X=interp1(X,Vh,x,'spline');
legend("实际值","理论值");
plot(x,Interp_X,'m-');
t=title('电磁铁端口磁场分布');
t.FontSize=14;
xlabel("X/mm");
ylabel("V_{H}/mV");
hold off

clear ans t a x