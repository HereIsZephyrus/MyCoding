clc;close all;clear
data=xlsread('第二段摩擦力.xlsx');

%%
% 根据你的需求，选择合适的阈值来判断拟合效果是否差
fit_threshold = 0.9; 

% 预分配数组来存储结果
curvature_radii = zeros(size(data, 1), 1);
lateral_accelerations = zeros(size(data, 1), 2);

% 循环处理每4个相邻数据点
for i = 1:size(data, 1) - 3
    % 获取纵向和横向加速度数据
    lateral_acc = data(i:i+3, 3);%横向
    longitudinal_acc = data(i:i+3, 4);%纵向

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
    velocity = data(i,2); % 你的线速度，需要根据实际情况调整
    lateral_acceleration = velocity^2 / curvature_radius;
    
    % 存储结果
    curvature_radii(i:i+3) = curvature_radius;
    lateral_accelerations(i:i+3) = lateral_acceleration;
end
for i = 1:length(lateral_accelerations)
     if (lateral_accelerations(i)) > 12
          lateral_accelerations(i) = 12;
     end
     if lateral_accelerations(i)< -12
         lateral_accelerations(i) = -12;
     end
end

figure
plot(curvature_radii)

if any(curvature_radii == 0)
    disp('存在0')
else
    disp('不存在0')
end