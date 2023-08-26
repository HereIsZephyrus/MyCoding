clc;close all;clear
data=readtable('路段3.xlsx');

timedata=table2array(data(10:15,10),'InputFormat','HH:mm:ss');
v=table2array(data(10:15,9));

time = datetime(timedata);

% 将时间转换为数值表示
time_numeric = datenum(time(:,:));

% 进行样条插值
time_interp = linspace(min(time_numeric), max(time_numeric), 1000); % 生成插值的时间点
v_interp = spline(time_numeric, v, time_interp); % 进行样条插值

% 绘制插值后的曲线
figure(1);
plot(time_interp, v_interp, 'b-', 'LineWidth', 2);
hold on;
plot(time_numeric, v, 'ro');
datetick('x', 'HH:MM:SS'); % 显示时间刻度
xlabel('时间');
ylabel('速度');
title('路段3 弯道插值v—t');
legend('插值曲线', '原始数据');

v_interp = v_interp';
time_interp = time_interp';
time_interp_datetime = datetime(time_interp, 'ConvertFrom', 'datenum'); % 将数值型时间点转换为 datetime 格式
time_interp_string = datestr(time_interp_datetime, 'HH:MM:SS'); % 将 datetime 转换为字符串格式 HH:mm:ss

disp(time_interp_string); % 显示转换后的时间字符串
