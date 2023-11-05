clc;clear;close all;

%% 数据输入
f0=38.89e3;
times=10:-1:1;
X1=[19.2860,18.7415,18.3191,17.8405,17.4043,16.9375,16.5827,16.1454,15.6832,15.2491];X1=X1/100;
lamda1=1/2*abs(sum(X1(6:10)-X1(1:5)))/5;    v1=lamda1*f0;
X2=[14.6896,14.1081,13.7700,13.3902,12.8847,12.4417,11.9839,11.5320,11.0785,10.6349];X2=X2/100;
lamda2=1/2*abs(sum(X2(6:10)-X2(1:5)))/5;    v2=lamda2*f0;
L=24:-2:14;L=L/100;
t=[859e-6,800e-6,717e-6,658e-6,604e-6,548e-6];
v3=2*mean(L./t);

%% 处理绘图
subplot(2,2,1);
hold on
[p,S] = polyfit(1:10,X1,1);
[yfit,delta]=polyval(p,1:10,S);
plot(times,yfit,'g-','LineWidth',1.2);
plot(times,yfit+2*delta,'m--',times,yfit-2*delta,'m--');
plot(times,X1,'b.');
legend("拟合数据","95%误差限","","测量数据",'Location','northwest');
ylabel('接受-发射源间距离/m','Interpreter','none');
xlabel('实验次数','Interpreter','none');
title("共振干涉法最大振幅位置时距离");
v=abs(p(1)*f0*2);
lamda=abs(p(1)*2e6);
str={strcat("波长\lambda=",num2str(lamda),"nm"),strcat("波速v=",num2str(v),"m/s")};
text(5,min(X1)+0.005,str);
hold off

subplot(2,2,2);
hold on
[p,S] = polyfit(1:10,X2,1);
[yfit,delta]=polyval(p,1:10,S);
plot(times,yfit,'g-','LineWidth',1.2);
plot(times,yfit+2*delta,'m--',times,yfit-2*delta,'m--');
plot(times,X2,'b.');
legend("拟合数据","95%误差限","","测量数据",'Location','northwest');
ylabel('接受-发射源间距离/m','Interpreter','none');
xlabel('实验次数','Interpreter','none');
title("相位比较法成特定斜率直线时距离");
v=abs(p(1)*f0*2);
lamda=abs(p(1)*2e6);
str={strcat("波长\lambda=",num2str(lamda),"nm"),strcat("波速v=",num2str(v),"m/s")};
text(5,min(X2)+0.005,str);
hold off

subplot(2,2,3);
hold on
[p,S] = polyfit(t,L,1);
[yfit,delta]=polyval(p,t,S);
plot(t,yfit,'g-','LineWidth',1.2);
plot(t,yfit+2*delta,'m--',t,yfit-2*delta,'m--');
plot(t,L,'b.');
legend("拟合数据","95%误差限","","测量数据",'Location','northwest');
ylabel('接受-发射源间距离','Interpreter','none');
xlabel('间隔时间/s','Interpreter','none');
title("时差法测量时间与距离对应关系");
v=abs(p(1));
str=strcat("波速v=",num2str(v),"m/s");
text(t(4),L(5)+0.005,str);
hold off