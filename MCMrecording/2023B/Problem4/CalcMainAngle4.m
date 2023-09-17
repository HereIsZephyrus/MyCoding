clc;close all;clear
load('interpolated_depth_data.mat')


% 或者创建等高线图
figure;
% contourf(X, Y, Z, 20); % 20 个等高线
[C,h]=contourf(X,Y,Z,20,'LineWidth',2,'LineStyle','--');
colorbar;
hold on
[gx,gy]=gradient(Z);
save('gx.mat','gx')
save('gy.mat',"gy")
% 计算XY平面上的梯度投影
gradient_magnitude = sqrt(gx.^2 + gy.^2);
% 计算平均梯度的方向与X轴的夹角
angle_with_x_axis_rad = atan2(mean(gy(:)), mean(gx(:)));
angle_with_x_axis_deg = rad2deg(angle_with_x_axis_rad);
% 显示平均梯度与X轴的夹角（度数）

disp(['平均梯度与X轴的夹角：', num2str(angle_with_x_axis_deg), '度']);
%%
% 计算直线1的端点坐标
line_length = 4;
x_center = mean(X(:));
y_center = mean(Y(:));
x1 = x_center - line_length / 2 * cosd(angle_with_x_axis_deg);
y1 = y_center - line_length / 2 * sind(angle_with_x_axis_deg);
x2 = x_center + line_length / 2 * cosd(angle_with_x_axis_deg);
y2 = y_center + line_length / 2 * sind(angle_with_x_axis_deg);

% 计算直线2的端点坐标（垂直于直线1）
angle_perpendicular = angle_with_x_axis_deg - 90; % 垂直角度
x3 = x_center - line_length / 2 * cosd(angle_perpendicular);
y3 = y_center - line_length / 2 * sind(angle_perpendicular);
x4 = x_center + line_length / 2 * cosd(angle_perpendicular);
y4 = y_center + line_length / 2 * sind(angle_perpendicular);

% 绘制直线1和直线2
plot([x1, x2], [y1, y2], 'b-', 'LineWidth', 4);
plot([x3, x4], [y3, y4], 'r', 'LineWidth', 4);
hold off;
%%
angle1=360-(180-angle_with_x_axis_deg);
angle2=angle1+90;
angle3=180+angle_with_x_axis_deg;
%%
% % 可选：保存图像到文件
% saveas(gcf, '主测线.png');
% % 关闭图形窗口
% close(gcf);

