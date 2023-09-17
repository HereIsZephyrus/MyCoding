clc;close all;clear
distanceO = [-800 -600 -400 -200 0 200 400 600 800];
distanceO1=distanceO(5:end);
distanceO2=distanceO(1:5);
D0=70;
a=1.5;
theta=120;
pi=180;
% 正半
D=[];
D(1,1)=D0;
theta_s=pi/2-(theta/2-a);
theta_d=pi/2-(theta/2+a);
idx = length(distanceO1);
Wis=[];
Wid=[];
N=[];
distance = [];
for i =2:idx
    d=distanceO1(1,i)-distanceO1(1,i-1);
    D(1,i)=D(1,i-1)+d*tand(a);
    distance(1,i)=d;
    D0=D(1,i-1);
end
distanceO(2,5:9)=D;

clear i idx d D0 distanceO1 distanceO2 D distance 
distanceO2=[0 -200 -400 -600 -800];
D0=70;
D=[];
D(1,1)=D0;
idx = length(distanceO2);
for i = 2:idx
    d=distanceO2(1,i)-distanceO2(1,i-1);
    D(1,i)=D(1,i-1)+d*tand(a);
    distance(1,i)=d;
    D0=D(1,i-1);
end
distanceO(2,4)=D(1,2);distanceO(2,3)=D(1,3);distanceO(2,2)=D(1,4);distanceO(2,1)=D(1,5);
clear i idx D0 D distanceO2 distance d
%%
idx = length(distanceO);
D=distanceO(2,:);
for i = -4:3
   d=distanceO(1,i+6)-distanceO(1,i+5);
   D0=70;
   wis=(D0-(i)*d*tand(a))*(sind(theta/2)/cosd(theta/2-a));
   wid=(D0-(i)*d*tand(a))*(sind(theta/2)/cosd(theta/2+a));

    Wis(1,i+5)=(D0-(i)*d*tand(a))*(sind(theta/2)/cosd(theta/2-a));
    Wid(1,i+5)=(D0-(i)*d*tand(a))*(sind(theta/2)/cosd(theta/2+a));
    N(1,i+5)=1-d/((D0-(i+1)*d*tand(a))/cosd(theta/2-a)+(D0-(i+2)*d*tand(a))/cosd(theta/2+a))*sind(theta/2-cosd(a));%这里改了i+1为了改索引
end

W=Wis+Wid;
distanceO(3,1:8)=W;
W1s=(D0-(4)*200*tand(a))*(sind(theta/2)/cosd(theta/2-a));
W1d=(D0-(4)*200*tand(a))*(sind(theta/2)/cosd(theta/2+a));
W1=W1s+W1d;
distanceO(3,9)=W1;

distanceO(4,2:9)=N;
disp(distanceO)
clear W1s W1d W1 W  wid wis i idx
% save('distanceO.mat')
% 可视化
figure 
plot(distanceO(2,:),'b^-','MarkerFaceColor','auto','MarkerEdgeColor','auto','MarkerSize',10,'LineWidth',4)
figure
plot(distanceO(3,:),'ro-','MarkerFaceColor','auto','MarkerEdgeColor','auto','MarkerSize',10,'LineWidth',4)
figure
plot(distanceO(4,2:9),'g*-','MarkerFaceColor','auto','MarkerEdgeColor','auto','MarkerSize',10,'LineWidth',4)
close all
%% 检验
e=(sind(a)/cosd(theta/2));
h=(1-e)/(1+e);
aaaa=Wis/Wid;
disp(aaaa)
disp(h)