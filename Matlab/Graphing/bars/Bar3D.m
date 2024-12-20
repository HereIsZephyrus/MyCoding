clc;clear;close all;
%% 数据准备
% 读取数据
XData=1:12;
YData = 2011:2013;
ZData = [1:12;4:15;7:18];

%% 颜色定义
map = addcolorplus(296);

%% 绘制三维柱状图
figureHandle = figure;
Width=0.6;
GO = bar3(ZData,Width);
hTitle = title(sprintf('Average Monthly Temperatures from %d to %d',YData(1),YData(3)));
hXLabel = xlabel('XAxis');
hYLabel = ylabel('YAxis');
hZLabel = zlabel('ZAxis');

%% 细节优化
% 赋色
colormap(map)

% 坐标区调整
set(gca, 'Box', 'off', ...                                                          % 边框
         'LineWidth', 1, 'GridLineStyle', '-',...                                   % 坐标轴线宽
         'XGrid', 'off', 'YGrid', 'off','ZGrid', 'on', ...                          % 网格
         'TickDir', 'out', 'TickLength', [.015 .015], ...                           % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off',  'ZMinorTick', 'off',...         % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1], 'ZColor', [.1 .1 .1],...      % 坐标轴颜色
         'Xticklabel',XData,...                                                    % X坐标轴刻度标签
         'Yticklabel',YData)                                % Y坐标轴刻度标签

% 字体和字号
set(gca, 'FontName', 'Helvetica')
set([hXLabel, hYLabel,hZLabel], 'FontName', 'AvantGarde')
set(gca, 'FontSize', 10)
set([hXLabel, hYLabel,hZLabel], 'FontSize', 12)
set(hTitle, 'FontSize', 20, 'FontWeight' , 'bold')

% 背景颜色
set(gcf,'Color',[1 1 1])

%% 图片输出
fileout = 'Bar3D';
print(figureHandle,'Bar3D.png','-r300','-dpng');