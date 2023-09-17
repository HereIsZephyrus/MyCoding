%% 研究共振频率和弦长的关系
clear;clc;
load data.mat
f=zeros(length(L),length(T));
n=1;
rou=5e-4;
for i=1:length(L)
    f(i,:)=n/(2*L(i))*sqrt(T/rou);
end
hold on
F1=plot(T,f.*f,'b*-');
F2=plot(T,realf.*realf,'g+-');
title("线密度为0.562g/m");
xlabel("张力T");
ylabel("频率f^2");
hold off

clear i j
save f.mat f
clear f

%% 研究共振频率和张力的关系，并计算波速
clear;clc;
load data.mat
clear L T m
m1=0.55;
m2=1.05;
T=[m1*g*[1:5],m2*g*[4:5]];
L=0.6;
f=zeros(length(L),length(T));
pre_v=zeros(length(L),length(T));

%rou1
rou=5.62e-4;
f=n/(2*L)*sqrt(T/rou);
pre_v=sqrt(T/rou);

subplot(2,1,1);
Fig=plot(T,f.*f,'b*-');
title("线密度为0.562g/m");
xlabel("张力T");
ylabel("频率f^2");

subplot(2,1,2);
hold on
plot(T,pre_v,'r*-');
plot(T,real_v,'g+-');
title("线密度为0.562g/m");
xlabel("张力T");
ylabel("速度v");
hold off

clear i j
save rou5.mat f pre_v Fig

%rou2
%{
rou=1.032e-4;
f=n/(2*L)*sqrt(T/rou);
pre_v=sqrt(T/rou);

subplot(2,2,2);
hold on
Fig=plot(T,f.*f,'b*-');
title("线密度为1.032g/m");
xlabel("张力T");
ylabel("频率f^2");

subplot(2,2,4);
plot(T,pre_v,'r*-');
plot(T,real_v,'g*-');
title("线密度为1.032g/m");
xlabel("张力T");
ylabel("速度v");
hold off
clear i j
save rou10.mat f pre_v Fig
%}