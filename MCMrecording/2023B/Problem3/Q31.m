clc;close all;clear
theta=120;
beta=40;%夹角
k=tand(beta);%斜率
a=1.5;%坡度
D0=110;%中心点海水深度
n=10*0.01;%重叠率
t=1852;%海里单位
xrange=4;
yrange=2;

Lamberda=sqrt(2*(cosd(theta/2)^2-sind(a)^2))*(sind(theta/2)/cosd(theta/2-a)+sind(theta/2)/cosd(theta/2+a));


syms x1
equation = (Lamberda/cosd(theta/2))*(D0+((2-x1)*t*tand(a)))*((cosd(theta/2-a))/(cosd(theta/2+a)+cosd(theta/2-a)))-x1*t==0;
solutions = solve(equation, x1);
x1=double(solutions);
X1points=x1;
%%
% 显示解的数值
disp(double(solutions));
clear equation solutions 
L=t*cosd(theta/2+a)*cosd(theta/2-a);
Wdi=(Lamberda/cosd(theta/2))*(D0+((2-x1)*t*tand(a)))*((cosd(theta/2-a))/(cosd(theta/2+a)+cosd(theta/2-a)));
Wsi=(Lamberda/cosd(theta/2))*(D0+((2-x1)*t*tand(a)))*((cosd(theta/2+a))/(cosd(theta/2+a)+cosd(theta/2-a)));
% u=sqrt(2*(cosd(theta/2)^2-sind(a)^2))*tand(theta/2);
% M=2*cosd(theta/2)*cosd(a)*(D0+2*t*tand(a));
% N=t*tand(a);
% O=cosd(theta/2-a);
% P=cosd(theta/2+a);
% Y=((1-n)/L)*u;

x2 = 0; % 初始化x2的值为0
x2_values = []; % 用于存储满足条件的x2值的数组

while x2 < xrange
    syms x2_symbol
    equation = x2_symbol - x1 - ((1-n) * cosd(a)*(Wdi + (Lamberda/cosd(theta/2))*(D0+((2-x2)*t*tand(a)))*((cosd(theta/2-a))/(cosd(theta/2+a)+cosd(theta/2-a))))/t) == 0;
    solutions = solve(equation, x2_symbol);
    x2 = double(solutions);
    wdii= (Lamberda/cosd(theta/2))*(D0+((2-x2)*t*tand(a)))*((cosd(theta/2-a))/(cosd(theta/2+a)+cosd(theta/2-a)));
    % 如果x2小于4，则将其存入数组中
    if x2*t +wdii< 4*t
        x2_values = [x2_values, x2];
    end
    
    % 更新x1为当前x2的值
    x1 = x2;
    Wdi=(Lamberda/cosd(theta/2))*(D0+((2-x1)*t*tand(a)))*((cosd(theta/2-a))/(cosd(theta/2+a)+cosd(theta/2-a)));
end

x2_values=[X1points,x2_values];
save('xi.mat',"x2_values")
numx=length(x2_values);
fprintf('一共需要布线 %.2f 条\n ', numx);
Allong=numx*yrange*t;
fprintf('布线长度 %.2f m\n ',Allong);
Allong1=numx*yrange;
fprintf('布线长度 %.2f 海里\n ',Allong1);