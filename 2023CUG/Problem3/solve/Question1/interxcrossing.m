%%
clc;close all;clear

data=readtable('路段3.xlsx');
loaded_data = load('road_data.mat');

    % 获取当前路段的经纬度数据
    latitude = table2array(data(10:15,2));
    longitude =  table2array(data(10:15,3));
    



    % 进行插值
    num_points_interp = 1000; % 插值后的点数

    t_interp = linspace(1, length(latitude), num_points_interp);
    latitude_interp = interp1(1:length(latitude), latitude, t_interp, 'spline');
    longitude_interp = interp1(1:length(longitude), longitude, t_interp, 'spline');
        % 绘制当前路段的插值后的轨迹图，使用实心点作为标记符号
    plot(longitude_interp, latitude_interp, '.-', 'Color',[0.1, 0.2, 1], 'MarkerSize', 5);
    
    % 设置图形标题
    title('路段3 弯道');
    
    % 设置轴标签
    xlabel('Longitude');
    ylabel('Latitude');


     latitude_interp= latitude_interp';
     longitude_interp=longitude_interp';
