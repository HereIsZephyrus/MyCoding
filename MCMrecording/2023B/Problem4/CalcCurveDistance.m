clc;close all;clear
load('interpolated_depth_data.mat')

% figure
% mesh(X,Y,Z)

% 假设你有一个要查询的点的坐标 x_query 和 y_query
x1 = 4; % 例如，要查询的x坐标
y1 = 2.5; % 例如，要查询的y坐标
%第二个点
x2 = 4; % 例如，要查询的x坐标
y2 = 3; % 例如，要查询的y坐标


% 使用距离公式计算所有网格点到查询点的距离
distances = sqrt((X - x1).^2 + (Y - y1).^2);

% 找到最近点的索引
[min_distance, index] = min(distances(:));

% 使用索引获取对应的Z值
z1 = Z(index);

% 打印结果
fprintf('对于查询点 (%.2f, %.2f)，最近的点坐标为 (%.2f, %.2f)，对应的Z值为 %.2f\n', x1, y1, X(index), Y(index), z1);
clear min_distance index distances
%%
% 使用距离公式计算所有网格点到查询点的距离
distances = sqrt((X - x2).^2 + (Y - y2).^2);

% 找到最近点的索引
[min_distance, index] = min(distances(:));

% 使用索引获取对应的Z值
z2 = Z(index);

% 打印结果
fprintf('对于查询点 (%.2f, %.2f)，最近的点坐标为 (%.2f, %.2f)，对应的Z值为 %.2f\n', x2, y2, X(index), Y(index), z2);
clear min_distance index distances

% 假设你有两个点的坐标 (x1, y1) 和 (x2, y2)
% 查找这两个点在X和Y坐标上的索引
[~, index1_x] = min(abs(X(1, :) - x1));
[~, index1_y] = min(abs(Y(:, 1) - y1));
[~, index2_x] = min(abs(X(1, :) - x2));
[~, index2_y] = min(abs(Y(:, 1) - y2));

% 确保索引在合理范围内
index1_x = min(max(index1_x, 1), size(X, 2));
index1_y = min(max(index1_y, 1), size(Y, 1));
index2_x = min(max(index2_x, 1), size(X, 2));
index2_y = min(max(index2_y, 1), size(Y, 1));

% 计算两个点之间的差分
diff_x = X(index2_y, index2_x) - X(index1_y, index1_x);
diff_y = Y(index2_y, index2_x) - Y(index1_y, index1_x);
diff_z = Z(index2_y, index2_x) - Z(index1_y, index1_x);

% 计算曲面长度（差分和表示）
arc_length = sqrt(diff_x^2 + diff_y^2 + diff_z^2);

% 打印结果
fprintf('两点之间在曲面上的长度(覆盖宽度)为 %.2f\n', arc_length);
