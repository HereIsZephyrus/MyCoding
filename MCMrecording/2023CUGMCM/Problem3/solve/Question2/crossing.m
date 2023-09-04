clc;close all;clear
% 读取数据
filename = '路段3弯道.xlsx';
data = xlsread(filename);

% 假设数据的列顺序是：时间、纬度、经度、速度、速度方向角
time = data(:, 2);
latitude = data(:, 4);
longitude = data(:, 5);
speed = data(:, 6);

%%
latitude1 = (data(:,4));
longitude1 =(data(:,5));
displacement=[latitude1,longitude1];
% 初始化一个向量，用于存储每两个相邻点之间的角度
angles3 = [];
% 遍历每一对相邻点
for i = 1:size(displacement, 1) - 1
    % 计算经度差和纬度差
    delta_longitude = displacement(i+1, 2) - displacement(i, 2);
    delta_latitude = displacement(i+1, 1) - displacement(i, 1);
    % 计算连线与正北方向的角度
    angle_radians = atan2(delta_longitude, delta_latitude);
    if angle_radians == 0
       angle_radians = angles3 (i-1);
    end
    % 将角度添加到向量中
    angles3 = [angles3; angle_radians];
end
angles_degrees3 = rad2deg(angles3);
clear i n

angles3 = [0; angles_degrees3]; 
direction =angles3;
%%
% 计算速度的差分得到加速度
acceleration = diff(speed);

acceleration = [0; acceleration];
acceleration(1)=acceleration(2);
acceleration = acceleration*100;
% 根据速度方向角计算横向加速度和径向加速度
lateral_acceleration = acceleration .* sind(direction);
radial_acceleration = acceleration .* cosd(direction);
radial_acceleration(1)=radial_acceleration(2);
% 绘制图形
figure;

subplot(3, 1, 1);
plot(time(1:end), lateral_acceleration, 'b');
xlabel('时间');
ylabel('横向加速度');
title('横向加速度随时间变化');
datetick('x', 'HH:MM:SS', 'keeplimits');

subplot(3, 1, 2);
plot(time(1:end), radial_acceleration, 'r');
xlabel('时间');
ylabel('径向加速度');
title('径向加速度随时间变化');
datetick('x', 'HH:MM:SS', 'keeplimits');


subplot(3, 1, 3);
plot(time(1:end), acceleration, 'r');
xlabel('时间');
ylabel('加速度大小');
title('加速度大小随时间变化');

% 将横坐标时间格式化为 HH:mm:ss
datetick('x', 'HH:MM:SS', 'keeplimits');
sgtitle('加速度随时间变化');