clc;close ;clear
load('xi.mat')
data=x2_values;
xi=data;
% 创建一个新的图形窗口
figure;

% 绘制2x4的矩形，左下角坐标为(0, 0)，宽度为4，高度为2
rectangle('Position', [0, 0, 4, 2], 'EdgeColor', 'k', 'FaceColor', 'none','LineWidth',2);

% 循环绘制渐变颜色的直线
numLines = length(xi);
colorMap = colormap(jet(numLines)); % 选择渐变颜色映射
for i = 1:numLines
    color = colorMap(i, :);
    x = [xi(i), xi(i)];
    y = [0, 2]; % 直线的y范围从0到4
    line(x, y, 'Color', color, 'LineWidth', 4);
end

% 显示颜色条以匹配渐变颜色
colorbar;

% 可选：设置坐标轴范围，确保矩形和直线都可见
axis([0,4, 0, 2]);

% % 可选：保存图像到文件
% saveas(gcf, '第三问.png');
% 
% % 关闭图形窗口
% close(gcf);