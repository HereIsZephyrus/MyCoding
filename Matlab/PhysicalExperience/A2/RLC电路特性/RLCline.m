clc;clear;close all;
f0=5020;    U0=5.88;
f=[540.8,1034,2500,4000,6259,7587,8830,11044];
omiga=2*pi*f;
U=[0.208,1.02,1.36,3.52,3.64,2.24,1.68,1.16];
phi_e=[-87.5,-85.2,-78.1,-53.7,52.5,68.5,72,80];
R0=100;C=0.1e-6;L=10e-3; %参数设置

% 理论计算
R=abs(omiga*L*1i+1./(omiga*C*1i)+R0);
R=[R(1:4),R0,R(5:8)];U=[U(1:4),U0,U(5:8)];f=[f(1:4),f0,f(5:8)];
omiga=2*pi*f;
phi_t=atand((omiga*L-1./(omiga*C))/R0);phi_e=[phi_e(1:4),0,phi_e(5:8)];
dphi=phi_t-phi_e;vphi=var(dphi);
%% 图像呈现
subplot(1,2,1);
hold on
I=U./R;
plot(f,I,'b*');
ff=linspace(min(f),max(f),1000);
ii=spline(f,I,ff);
plot(ff,ii,'g-');
xlabel("电流频率f/Hz");
ylabel("电流I/I_{max}");
title("RLC电路电流随频率变化关系");

hold off
subplot(1,2,2);
hold on
lgR=log(R);lgF=log(f);
plot(lgF,lgR,'b*');
lff=linspace(min(lgF),max(lgF),1000);
lrr=spline(lgF,lgR,lff);
plot(lff,lrr,'g-');
xlabel("电流频率log_{10}f/Hz");
ylabel("等效电阻log_{10}R/R_{总}");
title("RLC电路总电阻与频率变化关系");
hold off
