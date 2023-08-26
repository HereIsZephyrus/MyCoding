clc;close all;clear
loaded_data = load('road_data.mat');
Roaddata_loaded = loaded_data.Roaddata;
datain3=readtable('路段3.xlsx');
n = 3;%求路段n距离
% latitude1 = [Roaddata_loaded(n).latitude];
% longitude1 = [Roaddata_loaded(n).longitude];
latitude1 = table2array(datain3(:,3));
longitude1 = table2array(datain3(:,2));
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
%%
timedata3=table2array(datain3(15:24,10),'InputFormat','HH:mm:ss');
time3 = datetime(timedata3);
% 将时间转换为数值表示
time_numeric3 = datenum(time3(:,:));
angles3inter = angles3(15:24);
% 进行样条插值
time_interp3 = linspace(min(time_numeric3), max(time_numeric3), 1000); % 生成插值的时间点
angle_interp3 = spline(time_numeric3, angles3inter, time_interp3); % 进行样条插值


% 绘制插值后的曲线
figure(1);
plot(time_interp3, angle_interp3, 'b-', 'LineWidth', 2);
hold on;
plot(time_numeric3(:,:), angles3inter(:,:), 'ro');
datetick('x', 'HH:MM:SS'); % 显示时间刻度
xlabel('时间');
ylabel('速度');
title('路段3 正北偏向角弯道变化');
legend('插值曲线', '原始数据');

angle_interp3 = angle_interp3';
