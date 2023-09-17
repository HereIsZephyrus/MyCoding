clc;close all;clear
Oceandistance=[0 0.3 0.6 0.9 1.2 1.5 1.8 2.1];
OD=Oceandistance;
OceanD=Oceandistance*1852;
clear Oceandistance
Oceandistance = OceanD;
clear OceanD

beta=[0 45 90 135 180 225 270 315];
idx=length(Oceandistance);
D0=120;
idy=length(beta);
a=1.5;
theta=120;
W=[];
j=[];
p=[];
m=[];
for i = 1:idx
    s=Oceandistance(1,i);
    for p=1:idy
    b=beta(1,p);

    D=D0-s*sind(b);%没有意义
 

    J=(D0+s*cosd(b)*tand(a))^2;%这个是D的平方
    j(p,i)=J;
    waterH(p,i)=sqrt(J);%距离

    K=(1-(sind(a)/cosd(theta/2))^2);
    k(p,i)=K;

    M=1/2-2*(sind(b)*sind(a))^2/(cosd(theta/2)^2);
    m(p,i)=M;

    L=sind(theta/2)^2*(1/(cosd(theta/2-a)^2)+1/(cosd(theta/2+a)^2));

    w=sqrt(J*L*K/M);
    W(p,i)=w;

    end
 end
disp(W)
%%
figure;

nPlots = 8;
colors = jet(nPlots); % 使用jet色图来创建渐变颜色

for i = 1:nPlots
    subplot(4, 2, i);
    
    % 计算当前子图的颜色
    currentColor = colors(i, :);
    
    % 绘制线条
    plot(W(i, :), 'o-', 'MarkerFaceColor', 'auto', 'MarkerEdgeColor', 'auto', 'MarkerSize', 10, 'LineWidth', 4, 'Color', currentColor);
    title(['航段' num2str(i)]);
end

%%
close all
C=beta';
CC=[0;C];
clear C
Q2data(:,1)=CC;
clear CC
OD=[0,OD];
Q2data(1,1:9)=OD;
clear OD
Q2data(2:end,2:end)=W;
%save("Q2data.mat")
