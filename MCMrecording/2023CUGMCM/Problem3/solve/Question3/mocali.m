clc;close all;clear

data=xlsread('摩擦力.xlsx');
data2=xlsread('摩擦因数.xlsx');

Fnr = zeros(size(data, 1), 1);
Rr = zeros(size(data, 1), 1);
Cnr = zeros(size(data, 1), 1);
M0 = zeros(size(data, 1), 1);
%% 导入参数
beta = data(:,end);%偏角差分
R = data(:,end-1);%曲率半径
v = data(:,2);

%% 需要设立的参数
n = 1;%                      n的值不同，对应的路段摩擦因数不同
% 1.混凝土
% 2.沥青
% 3.碎石
% 4.农田
% 5.土路
% 6.黏土
% 7.煤矸石路
% 8.沙丘
% 9.冰雪

u=data2(n,1);%摩擦系数
mc=5000;%车质量
mp=0;%人质量
T=1.725;%左右前车轮距离
D=0.4318;%轮胎直径
W=0.195;%胎宽
sigma = 12;
p=100*1000;%气压
ALLlength=5;
Ltf=2;%前车轮到质心距离
Ltb=2;%后车轮到质心距离
g=9.81;%重力加速度

%% 二次参数 常数
k = 0.0225*W+0.63;
G = (mc+mp)*g;
delta = (k * G) / (W^0.7 * D^0.43 * p^0.6);
l = 1.7 * sqrt(D * delta + delta^2);
Gc=mc*g;
Gf=( Ltb / (2*Ltb+Ltf) )*Gc;

%% 二次参数 矩阵
for i = 1:length(data(:,1))
bet=beta(i);
r = R(i);
V = v(i);
bb = beta(i);
rr = sqrt((r * cosd(bet) - (T/2))^2 + (Ltb + Ltf)^2);
m0 = (Gf * (bb / pi)) * (sigma + (D / 2 - delta * tan(sigma))) * sin(2 * sigma);
cnr = V^2 / (u * g * r);
Rr(i)=rr;
Cnr(i)=cnr;
M0(i)=m0;
end
Fnv = Cnr;
clear i rr m0
%% 摩擦力
for i=1:length(data(:,1))
    fnv = Fnv(i);
    rr = Rr(i);
    m0 = M0(i);
    fnr = (((8 / (9 * pi)) * fnv * G * l)+m0) / rr;
    Fnr(i)=fnr;
end

%% 时间
time = data(:,1);
timeneed = datetime(time, 'ConvertFrom', 'datenum'); % 将数值型时间点转换为 datetime 格式
% 假设 Fnr 是一个包含滚动摩擦力数据的数组
for i = 1:length(Fnr)
    while Fnr(i) > 10000
        Fnr(i) = Fnr(i) / 10;
    end
end
% 找出 Fnr 大于1000的索引
index = Fnr > 1000000000;
% 去掉对应的 timeneed 值
filtered_timeneed = timeneed(~index);
filtered_Fnr = Fnr(~index);

time_string = datestr(filtered_timeneed, 'HH:MM:SS'); % 将 datetime 转换为字符串格式 HH:mm:ss
%%
% 绘制散点图
subplot(2,1,1)

scatter(filtered_timeneed, filtered_Fnr);
xlabel('时间');
ylabel('摩擦力');
subplot(2,1,2)
plot(filtered_timeneed,filtered_Fnr);
xlabel('时间');
ylabel('摩擦力');

sgtitle('摩擦力-时间')
