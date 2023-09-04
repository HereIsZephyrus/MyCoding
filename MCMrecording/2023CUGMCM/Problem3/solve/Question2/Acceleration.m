clc;close all;clear
% 读取数据
filename = '路段1.xlsx';
data = xlsread(filename);

% 假设数据的列顺序是：时间、纬度、经度、速度、速度方向角
time = data(:, 1);
latitude = data(:, 3);
longitude = data(:, 4);
speed = data(:, 5);
direction = data(:, 6);

% 计算速度的差分得到加速度
acceleration = diff(speed);

acceleration = [0; acceleration];
acceleration = acceleration;
% 根据速度方向角计算横向加速度和径向加速度
lateral_acceleration = acceleration .* sind(direction);
radial_acceleration = acceleration .* cosd(direction);
% 计算加速度的大小
acceleration_magnitude = (sqrt(lateral_acceleration.^2 + radial_acceleration.^2));

needdata=[];
needdata(:,1)=radial_acceleration;%横向加速度
needtime(:,1)=time;%时间
needdata2=[];
needdata2(:,1)=lateral_acceleration;%纵向
needdata3=[];
needdata3(:,1)=acceleration;%加速度大小
v=[];
v(:,1)=speed;%速度
angle=[];
angle(:,1)=direction;%方向
% 绘制图形
figure;

subplot(3, 1, 1);
plot(time(1:end), lateral_acceleration, 'b');
xlabel('时间');
ylabel('横向加速度');
title('横向加速度随时间变化');
datetick('x', 'HH:MM:SS', 'keeplimits');

subplot(3, 1, 2);
plot(time(1:end), radial_acceleration, 'k');
xlabel('时间');
ylabel('径向加速度');
title('径向加速度随时间变化');
datetick('x', 'HH:MM:SS', 'keeplimits');
sgtitle('加速度随时间变化');


subplot(3, 1, 3);
plot(time(1:end), acceleration, 'r');
xlabel('时间');
ylabel('加速度大小');
title('加速度大小随时间变化');
datetick('x', 'HH:MM:SS', 'keeplimits');
sgtitle('加速度随时间变化');

%%
filename = 'E:\1数学建模2023\2023国赛（）\第三次培训\问题二\路段2.xlsx';
data = xlsread(filename);

% 假设数据的列顺序是：时间、纬度、经度、速度、速度方向角
time = data(:, 1);
latitude = data(:, 3);
longitude = data(:, 4);
speed = data(:, 5);
direction = data(:, 6);

% 计算速度的差分得到加速度
acceleration = diff(speed);

acceleration = [0; acceleration];
acceleration = acceleration;
% 根据速度方向角计算横向加速度和径向加速度
lateral_acceleration = acceleration .* sind(direction);
radial_acceleration = acceleration .* cosd(direction);
% 计算加速度的大小
acceleration_magnitude = sqrt(lateral_acceleration.^2 + radial_acceleration.^2);
needdata(:,2)=radial_acceleration;
needtime(:,2)=time;
needdata2(:,2)=lateral_acceleration;
needdata3(:,2)=acceleration;
v(:,2)=speed;
angle(:,2)=direction;
% 绘制图形
figure;

subplot(3, 1, 1);
plot(time(1:end), lateral_acceleration, 'b');
xlabel('时间');
ylabel('横向加速度');
title('横向加速度随时间变化');
datetick('x', 'HH:MM:SS', 'keeplimits');

subplot(3, 1, 2);
plot(time(1:end), radial_acceleration, 'k');
xlabel('时间');
ylabel('径向加速度');
title('径向加速度随时间变化');
% 将横坐标时间格式化为 HH:mm:ss
datetick('x', 'HH:MM:SS', 'keeplimits');


subplot(3, 1, 3);
plot(time(1:end), acceleration, 'r');
xlabel('时间');
ylabel('加速度大小');
title('加速度大小随时间变化');
datetick('x', 'HH:MM:SS', 'keeplimits');
sgtitle('加速度随时间变化');

%%
filename = 'E:\1数学建模2023\2023国赛（）\第三次培训\问题二\路段3.xlsx';
data = xlsread(filename);

% 假设数据的列顺序是：时间、纬度、经度、速度、速度方向角
time = data(:, 1);
latitude = data(:, 3);
longitude = data(:, 4);
speed = data(:, 5);
direction = data(:, 6);

% 计算速度的差分得到加速度
acceleration = diff(speed);

acceleration = [0; acceleration];
acceleration = acceleration;
% 根据速度方向角计算横向加速度和径向加速度
lateral_acceleration = acceleration .* sind(direction);
radial_acceleration = acceleration .* cosd(direction);
% 计算加速度的大小
acceleration_magnitude = sqrt(lateral_acceleration.^2 + radial_acceleration.^2);
needdata(:,3)=radial_acceleration;
needtime(:,3)=time;
needdata2(:,3)=lateral_acceleration;
needdata3(:,3)=acceleration;
v(:,3)=speed;
angle(:,3)=direction;
% 绘制图形
figure;

subplot(3, 1, 1);
plot(time(1:end), lateral_acceleration, 'b');
xlabel('时间');
ylabel('横向加速度');
title('横向加速度随时间变化');
datetick('x', 'HH:MM:SS', 'keeplimits');

subplot(3, 1, 2);
plot(time(1:end), radial_acceleration, 'k');
xlabel('时间');
ylabel('径向加速度');
title('径向加速度随时间变化');
% 将横坐标时间格式化为 HH:mm:ss
datetick('x', 'HH:MM:SS', 'keeplimits');


subplot(3, 1, 3);
plot(time(1:end), acceleration, 'r');
xlabel('时间');
ylabel('加速度大小');
title('加速度大小随时间变化');

sgtitle('加速度随时间变化');
% 将横坐标时间格式化为 HH:mm:ss
datetick('x', 'HH:MM:SS', 'keeplimits');
%%
filename = 'E:\1数学建模2023\2023国赛（）\第三次培训\问题二\路段4.xlsx';
data = xlsread(filename);

% 假设数据的列顺序是：时间、纬度、经度、速度、速度方向角
time = data(1:500, 1);
latitude = data(1:500, 3);
longitude = data(1:500, 4);
speed = data(1:500, 5);
direction = data(1:500, 6);

% 计算速度的差分得到加速度
acceleration = diff(speed);

acceleration = [0; acceleration];
acceleration = acceleration;
% 根据速度方向角计算横向加速度和径向加速度
lateral_acceleration = acceleration .* sind(direction);
radial_acceleration = acceleration .* cosd(direction);
% 计算加速度的大小
acceleration_magnitude = sqrt(lateral_acceleration.^2 + radial_acceleration.^2);
needdata(1:500,4)=radial_acceleration;
needtime(1:500,4)=time;
needdata2(1:500,4)=lateral_acceleration;
needdata3(1:500,4)=acceleration;
v(1:500,4)=speed;
angle(1:500,4)=direction;
% 绘制图形
figure;

subplot(3, 1, 1);
plot(time(1:end), lateral_acceleration, 'b');
xlabel('时间');
ylabel('横向加速度');
title('横向加速度随时间变化');
datetick('x', 'HH:MM:SS', 'keeplimits');

subplot(3, 1, 2);
plot(time(1:end), radial_acceleration, 'k');
xlabel('时间');
ylabel('径向加速度');
title('径向加速度随时间变化');
datetick('x', 'HH:MM:SS', 'keeplimits');



subplot(3, 1, 3);
plot(time(1:end), acceleration, 'r');
xlabel('时间');
ylabel('加速度大小');
title('加速度大小随时间变化');
datetick('x', 'HH:MM:SS', 'keeplimits');
sgtitle('加速度随时间变化');


%%
filename = 'E:\1数学建模2023\2023国赛（）\第三次培训\问题二\路段4.xlsx';
data = xlsread(filename);

% 假设数据的列顺序是：时间、纬度、经度、速度、速度方向角
time = data(501:1000, 1);
latitude = data(501:1000, 3);
longitude = data(501:1000, 4);
speed = data(501:1000, 5);
direction = data(501:1000, 6);

% 计算速度的差分得到加速度
acceleration = diff(speed);

acceleration = [0;acceleration];
acceleration = acceleration;
% for i = 1:length(acceleration)
% if acceleration(i) < -12
%    acceleration(i) = -11.5 ; 
% end
% end
% 根据速度方向角计算横向加速度和径向加速度
lateral_acceleration = acceleration .* sind(direction);
radial_acceleration = acceleration .* cosd(direction);
% 计算加速度的大小
acceleration_magnitude = sqrt(lateral_acceleration.^2 + radial_acceleration.^2);
needdata(501:1000,4)=radial_acceleration;
needtime(501:1000,4)=time;
needdata2(501:1000,4)=lateral_acceleration;
needdata3(501:1000,4)=acceleration;
v(501:1000,4)=speed;
angle(501:1000,4)=direction;
% 绘制图形
figure;

subplot(3, 1, 1);
plot(time(1:end), lateral_acceleration, 'b');
xlabel('时间');
ylabel('横向加速度');
title('横向加速度随时间变化');
datetick('x', 'HH:MM:SS', 'keeplimits');

subplot(3, 1, 2);
plot(time(1:end), radial_acceleration, 'k');
xlabel('时间');
ylabel('径向加速度');
title('径向加速度随时间变化');
datetick('x', 'HH:MM:SS', 'keeplimits');


%%

% close all;

figure;

subplot(4,1,1)
plot(needtime(:,1), needdata(:,1), 'Color', [0.5 0.5 0.5])
xlabel('时间');
ylabel('径向加速度');
title('径向加速度随时间变化');
datetick('x', 'HH:MM:SS', 'keeplimits');

subplot(4,1,2)
plot(needtime(:,2), needdata(:,2), 'r')
xlabel('时间');
ylabel('径向加速度');
title('径向加速度随时间变化');
datetick('x', 'HH:MM:SS', 'keeplimits');

subplot(4,1,3)
plot(needtime(:,3), needdata(:,3), 'Color', [0.1 0.1 0.8])
xlabel('时间');
ylabel('径向加速度');
title('径向加速度随时间变化');
datetick('x', 'HH:MM:SS', 'keeplimits');

subplot(4,1,4)
plot(needtime(:,4), needdata(:,4), 'Color', [0.1 0.8 0.8])
xlabel('时间');
ylabel('径向加速度');
title('径向加速度随时间变化');
datetick('x', 'HH:MM:SS', 'keeplimits');
%
figure;

subplot(4,1,1)
plot(needtime(:,1), needdata2(:,1), 'Color', [0.5 0.5 0.5])
xlabel('时间');
ylabel('横向加速度');
title('横向加速度随时间变化');
datetick('x', 'HH:MM:SS', 'keeplimits');

subplot(4,1,2)
plot(needtime(:,2), needdata2(:,2), 'r')
xlabel('时间');
ylabel('横向加速度');
title('横向加速度随时间变化');
datetick('x', 'HH:MM:SS', 'keeplimits');

subplot(4,1,3)
plot(needtime(:,3), needdata2(:,3), 'Color', [0.1 0.1 0.8])
xlabel('时间');
ylabel('横向加速度');
title('横向加速度随时间变化');
datetick('x', 'HH:MM:SS', 'keeplimits');

subplot(4,1,4)
plot(needtime(:,4), needdata2(:,4), 'Color', [0.1 0.8 0.8])
xlabel('时间');
ylabel('横向加速度');
title('横向加速度随时间变化');
datetick('x', 'HH:MM:SS', 'keeplimits');
%
figure

subplot(4,1,1)
plot(needtime(:,1), needdata3(:,1), 'Color', [0.5 0.5 0.5])
xlabel('时间');
ylabel('横向加速度');
title('加速度大小随时间变化');
datetick('x', 'HH:MM:SS', 'keeplimits');

subplot(4,1,2)
plot(needtime(:,2), needdata3(:,2), 'r')
xlabel('时间');
ylabel('横向加速度');
title('加速度大小随时间变化');
datetick('x', 'HH:MM:SS', 'keeplimits');

subplot(4,1,3)
plot(needtime(:,3), needdata3(:,3), 'Color', [0.1 0.1 0.8])
xlabel('时间');
ylabel('横向加速度');
title('加速度大小随时间变化');
datetick('x', 'HH:MM:SS', 'keeplimits');

subplot(4,1,4)
plot(needtime(:,4), needdata3(:,4), 'Color', [0.1 0.8 0.8])
xlabel('时间');
ylabel('横向加速度');
title('加速度大小随时间变化');
datetick('x', 'HH:MM:SS', 'keeplimits');

%%
num_columns = size(needdata, 2); % 获取列数

for col = 1:num_columns
    data = needdata(:, col);
    v_data = v(:,col);
    combined_condition_count = sum((v_data > 0 & data > 0) | (v_data < 0 & data < 0));%加速
    combined_condition_count2= sum((v_data > 0 & data < 0) | (v_data < 0 & data > 0));%减速
    % 计算大于0的元素占比
    positive_percentage = combined_condition_count/ numel(data) * 100;
    
    % 计算小于0的元素占比
    negative_percentage = combined_condition_count2 / numel(data) * 100;
    
    % 显示结果
    fprintf('列 %d:\n', col);
    fprintf('径向加速大于0的占比: %.2f%%\n', positive_percentage);
    fprintf('径向加速小于0的占比: %.2f%%\n', negative_percentage);
    fprintf('\n');
end
%%
clear num_columns
num_columns = size(needdata2, 2); % 获取列数

for col = 1:num_columns
    data2 = needdata2(:, col);
    v_data2 = v(:,col);
    combined_condition_count21 = sum((v_data2 > 0 & data2 > 0) | (v_data2 < 0 & data2 < 0));%加速
    combined_condition_count22= sum((v_data2 > 0 & data2 < 0) | (v_data2 < 0 & data2 > 0));%减速
    % 计算大于0的元素占比
    positive_percentage2 = combined_condition_count21/ numel(data2) * 100;
    
    % 计算小于0的元素占比
    negative_percentage2 = combined_condition_count22 / numel(data2) * 100;
    % 显示结果
    fprintf('列 %d:\n', col);
    fprintf('横向加速大于0的占比: %.2f%%\n', positive_percentage2);
    fprintf('横向加速小于0的占比: %.2f%%\n', negative_percentage2);
    fprintf('\n');
end
%% 调整
clear num_columns
num_columns = size(angle, 2); % 列数

for col = 1:num_columns
    angle_data = angle(:, col);
    
    num_elements = numel(angle_data);
    left_adjustment_count = 0;
    right_adjustment_count = 0;
    
    for i = 2:num_elements
        if angle_data(i) > angle_data(i - 1)
            left_adjustment_count = left_adjustment_count + 1;
        elseif angle_data(i) < angle_data(i - 1)
            right_adjustment_count = right_adjustment_count + 1;
        end
    end
    
    fprintf('第 %d 列:\n', col);
    fprintf('向左调整计数器: %d\n', left_adjustment_count);
    fprintf('向右调整计数器: %d\n', right_adjustment_count);
    fprintf('\n');
end
% close all;clc;clear