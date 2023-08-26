clc;close all;clear
loaded_data = load('road_data.mat');
Roaddata_loaded = loaded_data.Roaddata;
%%
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

%%
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

%%

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

%%
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
% 将角度向量转换为度数表示
% 创建一个新的图形窗口
figure();

% 设置子图布局为 2x2 矩阵
subplot(2, 2, 1);

% 绘制第一个图，使用实心点
plot(angles_degrees, '-o', 'Color',[0.2, 0.2, 0.5]);
title('Plot 1');


% 设置子图布局为 2x2 矩阵
subplot(2, 2, 2);

% 绘制第二个图，使用实心点
plot(angles_degrees2, '-o','Color', [0.3, 0.3, 0.8]);
title('Plot 2');

% 设置子图布局为 2x2 矩阵
subplot(2, 2, 3);

% 绘制第三个图，使用实心点
plot(angles_degrees3, '-o', 'Color', [0.1, 0.2, 1]);
title('Plot 3');


% 设置子图布局为 2x2 矩阵
subplot(2, 2, 4);

% 绘制第四个图，使用实心点
plot(angles_degrees4, '-o', 'Color',[0.6, 0.2, 0.5]);
title('Plot 4');



