clc;close all;clear
data=readtable('附件1');

% 假设你的数据保存在名为 data 的表格变量中

% 提取经度、纬度、路段ID和时间数据
latitude = data.latitude;
longitude = data.longitude;
Road_id = data.track_id;
time = data.time;
%%
% 获取唯一的路段ID
unique_Roadid = unique(Road_id);

% 初始化一个结构体数组来存储不同路段的数据
Roaddata = struct('id', {}, 'latitude', {}, 'longitude', {},'time',{});
%%
% 遍历每个唯一的路段ID
for i = 1:numel(unique_Roadid)
    % 找到属于当前路段的数据
    Roaddata_idx = (Road_id == unique_Roadid(i));
    
    % 将数据存储在结构体中
    Roaddata(i).id = unique_Roadid(i);
    Roaddata(i).latitude = latitude(Roaddata_idx);
    Roaddata(i).longitude = longitude(Roaddata_idx);
    Roaddata(i).time = time(Roaddata_idx);
end

% 使用 save 函数保存结构体数据为 .mat 文件
save('road_data.mat', 'Roaddata');
%%

% 假设 Roaddata 是你存储路段数据的结构体

% 创建一个新的图形窗口
figure;

% 设置图形窗口大小
set(gcf, 'Position', [100, 100, 800, 600]);

% 遍历每个路段的数据
for i = 1:length(Roaddata)
    % 获取当前路段的经纬度数据
    latitude = Roaddata(i).latitude;
    longitude = Roaddata(i).longitude;
    
    % 计算颜色渐变
    color = [(i-1)/length(Roaddata), 0.5, 1 - (i-1)/length(Roaddata)];
    
    % 将图形分为2x2的网格，选择当前子图
    subplot(2, 2, i);
    
    % 绘制当前路段的轨迹图，使用实心点作为标记符号
    plot(longitude, latitude, '.-', 'Color', color, 'MarkerSize',10,'DisplayName', ['Road Segment ' num2str(i)]);
    
    % 设置图形标题
    title(['Road Segment ' num2str(i)]);
    
    % 设置轴标签
    xlabel('Longitude');
    ylabel('Latitude');
end

% 添加整体图形的图例
legend('Location', 'Best');

