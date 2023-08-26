clc;close all;clear
loaded_data = load('road_data.mat');
Roaddata_loaded = loaded_data.Roaddata;

%% 角度
n = 1;%求路段n距离
latitude1 = [Roaddata_loaded(n).latitude];
longitude1 = [Roaddata_loaded(n).longitude];
displacement=[latitude1,longitude1];
% 初始化一个向量，用于存储每两个相邻点之间的角度
angles = [];
% 遍历每一对相邻点
for i = 1:size(displacement, 1) - 1
    % 计算经度差和纬度差
    delta_longitude = displacement(i+1, 2) - displacement(i, 2);
    delta_latitude = displacement(i+1, 1) - displacement(i, 1);
    % 计算连线与正北方向的角度
    angle_radians = atan2(delta_longitude, delta_latitude);
    if angle_radians == 0
       angle_radians = angles (i-1);
    end
    % 将角度添加到向量中
    angles = [angles; angle_radians];
end
angles_degrees = rad2deg(angles);
clear i n


n = 2;%求路段n距离
latitude1 = [Roaddata_loaded(n).latitude];
longitude1 = [Roaddata_loaded(n).longitude];
displacement=[latitude1,longitude1];
% 初始化一个向量，用于存储每两个相邻点之间的角度
angles2 = [];
% 遍历每一对相邻点
for i = 1:size(displacement, 1) - 1
    % 计算经度差和纬度差
    delta_longitude = displacement(i+1, 2) - displacement(i, 2);
    delta_latitude = displacement(i+1, 1) - displacement(i, 1);
    % 计算连线与正北方向的角度
    angle_radians = atan2(delta_longitude, delta_latitude);
    if angle_radians == 0
       angle_radians = angles2 (i-1);
    end
    % 将角度添加到向量中
    angles2 = [angles2; angle_radians];
end
angles_degrees2 = rad2deg(angles2);
clear i n


n = 3;%求路段n距离
latitude1 = [Roaddata_loaded(n).latitude];
longitude1 = [Roaddata_loaded(n).longitude];
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


n = 4;%求路段n距离
latitude1 = [Roaddata_loaded(n).latitude];
longitude1 = [Roaddata_loaded(n).longitude];
displacement=[latitude1,longitude1];
% 初始化一个向量，用于存储每两个相邻点之间的角度
angles4 = [];
% 遍历每一对相邻点
for i = 1:size(displacement, 1) - 1
    % 计算经度差和纬度差
    delta_longitude = displacement(i+1, 2) - displacement(i, 2);
    delta_latitude = displacement(i+1, 1) - displacement(i, 1);
    % 计算连线与正北方向的角度
    angle_radians = atan2(delta_longitude, delta_latitude);
    if angle_radians == 0
       angle_radians = angles4 (i-1);
    end
    % 将角度添加到向量中
    angles4 = [angles4; angle_radians];
end
angles_degrees4 = rad2deg(angles4);
clear i n
%%
angles = [0; angles_degrees];
angles2 = [0; angles_degrees2];
angles3 = [0; angles_degrees3];
angles4 = [0; angles_degrees4];
angles41 = angles4(1:23);
angles42 = angles4(24:129);
%% 时间
datain1=readtable('路段1.xlsx');
datain2=readtable('路段2.xlsx');
datain3=readtable('路段3.xlsx');
datain4=readtable('路段4.xlsx');

timedata1=table2array(datain1(1:90,10),'InputFormat','HH:mm:ss');
time1 = datetime(timedata1);
%%
% 将时间转换为数值表示
time_numeric1 = datenum(time1(1:90));
% 进行样条插值
time_interp1 = linspace(min(time_numeric1), max(time_numeric1), 1000); % 生成插值的时间点
angle_interp1 = spline(time_numeric1, angles, time_interp1); % 进行样条插值

timedata2=table2array(datain2(1:113,10),'InputFormat','HH:mm:ss');
time2 = datetime(timedata2);
% 将时间转换为数值表示
time_numeric2 = datenum(time2(1:113));
% 进行样条插值
time_interp2 = linspace(min(time_numeric2), max(time_numeric2), 1000); % 生成插值的时间点
angle_interp2 = spline(time_numeric2, angles2, time_interp2); % 进行样条插值

timedata3=table2array(datain3(1:23,10),'InputFormat','HH:mm:ss');
time3 = datetime(timedata3);
% 将时间转换为数值表示
time_numeric3 = datenum(time2(1:23));
% 进行样条插值
time_interp3 = linspace(min(time_numeric3), max(time_numeric3), 1000); % 生成插值的时间点
angle_interp3 = spline(time_numeric3, angles3, time_interp3); % 进行样条插值

timedata41=table2array(datain4(1:23,10),'InputFormat','HH:mm:ss');
time41 = datetime(timedata41);
% 将时间转换为数值表示
time_numeric41 = datenum(time41(1:23));
% 进行样条插值
time_interp41 = linspace(min(time_numeric41), max(time_numeric41), 500); % 生成插值的时间点
angle_interp41 = spline(time_numeric41, angles41, time_interp41); % 行样条插值

timedata42=table2array(datain4(24:129,10),'InputFormat','HH:mm:ss');
time42 = datetime(timedata42);
% 将时间转换为数值表示
time_numeric42 = datenum(time42(1:106));
% 进行样条插值
time_interp42 = linspace(min(time_numeric42), max(time_numeric42), 500); % 生成插值的时间点
angle_interp42 = spline(time_numeric42 ,angles42, time_interp42); % 进行样条插值
%% 绘图
% 绘制插值后的曲线
figure(1);
plot(time_interp1, angle_interp1, 'b-', 'LineWidth', 2);
hold on;
plot(time_numeric1,  angles, 'ro');
datetick('x', 'HH:MM:SS'); % 显示时间刻度
xlabel('时间');
ylabel('正北偏向角');
title('路段1 插值θ—t');
legend('插值曲线', '原始数据');

figure(2);
plot(time_interp2, angle_interp2, 'b-', 'LineWidth', 2);
hold on;
plot(time_numeric2,  angles2, 'ro');
datetick('x', 'HH:MM:SS'); % 显示时间刻度
xlabel('时间');
ylabel('正北偏向角');
title('路段2 插值θ—t');
legend('插值曲线', '原始数据');

figure(3);
plot(time_interp3, angle_interp3, 'b-', 'LineWidth', 2);
hold on;
plot(time_numeric3,  angles3, 'ro');
datetick('x', 'HH:MM:SS'); % 显示时间刻度
xlabel('时间');
ylabel('正北偏向角');
title('路段3 插值θ—t');
legend('插值曲线', '原始数据');

figure(4);
plot(time_interp41, angle_interp41, 'b-', 'LineWidth', 2);
hold on;
plot(time_numeric41,  angles41, 'ro');
datetick('x', 'HH:MM:SS'); % 显示时间刻度
xlabel('时间');
ylabel('正北偏向角');
title('路段4 第一段 插值θ—t');
legend('插值曲线', '原始数据');

figure(5);
plot(time_interp42, angle_interp42, 'b-', 'LineWidth', 2);
hold on;
plot(time_numeric42,  angles42, 'ro');
datetick('x', 'HH:MM:SS'); % 显示时间刻度
xlabel('时间');
ylabel('正北偏向角');
title('路段4 第二段 插值θ—t');
legend('插值曲线', '原始数据');

%%
angle_interp1 =angle_interp1';
angle_interp2=angle_interp2';
angle_interp3=angle_interp3';
angle_interp41=angle_interp41';
angle_interp42=angle_interp42';

