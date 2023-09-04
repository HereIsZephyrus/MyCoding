clc; close all; clear
loaded_data = load('road_data.mat');
Roaddata = loaded_data.Roaddata;
% 创建一个新的图形窗口
figure;

% 设置图形窗口大小
set(gcf, 'Position', [100, 100, 800, 600]);

% 遍历每个路段的数据
for i = 1:length(Roaddata)
    % 获取当前路段的经纬度数据
    latitude = Roaddata(i).latitude;
    longitude = Roaddata(i).longitude;
    
    % 进行插值
    num_points_interp = 1000; % 插值后的点数
    t_interp = linspace(1, length(latitude), num_points_interp);
    latitude_interp = interp1(1:length(latitude), latitude, t_interp, 'spline');
    longitude_interp = interp1(1:length(longitude), longitude, t_interp, 'spline');
    
    % 计算颜色渐变
    color = [(i-1)/length(Roaddata), 0.5, 1 - (i-1)/length(Roaddata)];
    
    % 将图形分为2x2的网格，选择当前子图
    subplot(2, 2, i);
    
    % 绘制当前路段的插值后的轨迹图，使用实心点作为标记符号
    plot(longitude_interp, latitude_interp, '.-', 'Color', color, 'MarkerSize', 5, 'DisplayName', ['Road Segment ' num2str(i)]);
    
    % 设置图形标题
    title(['Interpolated Road Segment ' num2str(i)]);
    latitude_interp=latitude_interp';
    longitude_interp=longitude_interp';
    % 设置轴标签
    xlabel('Longitude');
    ylabel('Latitude');
end

% 添加整体图形的图例
legend('Location', 'Best');
