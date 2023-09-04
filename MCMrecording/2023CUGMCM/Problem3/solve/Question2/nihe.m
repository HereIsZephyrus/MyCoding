clc;close all;clear
data=xlsread('路段2.xlsx');


% 根据你的需求，选择合适的阈值来判断拟合效果是否差
fit_threshold = 0.9; 

% 预分配数组来存储结果
curvature_radii = zeros(size(data, 1), 5);
lateral_accelerations = zeros(size(data, 1), 6);

% 循环处理每4个相邻数据点
for i = 1:size(data, 1) - 3
    % 获取纵向和横向加速度数据
    longitudinal_acc = data(i:i+3, 8);%纵向
    lateral_acc = data(i:i+3, 7);%横向
    
    % 二次最小二乘拟合
    p = polyfit(longitudinal_acc, lateral_acc, 2);
    
    % 计算拟合的曲线
    fitted_curve = polyval(p, longitudinal_acc);
    
    % 计算R方来衡量拟合效果
    R_squared = 1 - sum((lateral_acc - fitted_curve).^2) / sum((lateral_acc - mean(lateral_acc)).^2);
    
    % 根据R方来判断使用二次还是三次拟合
    if R_squared < fit_threshold
        % 三次多项式拟合
        p = polyfit(longitudinal_acc, lateral_acc, 3);
    end
    
    % 创建拐点的虚拟点
    virtual_point = [longitudinal_acc(1) - 1, polyval(p, longitudinal_acc(1) - 1)];
    
    % 计算曲率半径
    curvature_radius = abs(1 / p(2));
    
    % 根据线速度计算横向加速度
    velocity = data(i,6); % 你的线速度，需要根据实际情况调整
    lateral_acceleration = velocity^2 / curvature_radius;
    
    % 存储结果
    curvature_radii(i:i+3) = curvature_radius;
    lateral_accelerations(i:i+3) = lateral_acceleration;
end
% for i = 1:length(lateral_accelerations)
%      if (lateral_accelerations(i)) > 12
%           lateral_accelerations(i) = 12;
%      end
%      if lateral_accelerations(i)< -12
%          lateral_accelerations(i) = -12;
%      end
% end


figure
plot(curvature_radii(:,1))

%%
figure
plot(curvature_radii)
%%
 hengxiang=data(:,7);
v= data(:,5);
R = curvature_radii(:,1);
needdata = hengxiang .* (R ./ v.^2);

negative_v_indices = find(v < 0);

% 剔除 v<0 对应的数据点
v(negative_v_indices) = [];
needdata(negative_v_indices) = [];

% % 假设 data 是包含您的数据的向量或矩阵
% z_scores = (needdata - mean(needdata)) / std(needdata);
% threshold = 4;  % 根据需要自行调整阈值
% 
% % 使用逻辑索引去除离群值
% needdata = needdata(abs(z_scores) <= threshold);

boxplot(needdata);
title('Box Plot');

% 计算上下限
Q1 = quantile(needdata, 0.25);
Q3 = quantile(needdata, 0.75);
IQR = Q3 - Q1;
lower_limit = Q1 - 1.5 * IQR;
upper_limit = Q3 + 1.5 * IQR;

% 使用逻辑索引去除离群值
needdata = needdata(needdata >= lower_limit & needdata <= upper_limit);
v = v(needdata >= lower_limit & needdata <= upper_limit);

figure
boxplot(needdata);
title('Box Plot');

% 计算上下限
Q1 = quantile(needdata, 0.25);
Q3 = quantile(needdata, 0.75);
IQR = Q3 - Q1;
lower_limit = Q1 - 1.5 * IQR;
upper_limit = Q3 + 1.5 * IQR;

% 使用逻辑索引去除离群值
needdata = needdata(needdata >= lower_limit & needdata <= upper_limit);
v = v(needdata >= lower_limit & needdata <= upper_limit);
%%
% 绘制散点图
figure
scatter(v, needdata);
xlabel('速度');
ylabel('needdata');
title('散点图：速度 vs. needdata');
ylabel('needdata')
xlim([0 21])
ylim([-1 1])
%%
median_value = abs(median(needdata));
fprintf('needdata 的中位数为: %.2ef\n', median_value);