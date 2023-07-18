clc;clear;close all;
%% 数据准备
XData=1:12;
YData = 2011:2013;
ZData = [1:12;4:15;7:18];

%% 颜色定义
map=addcolorplus(299);
%map = ColorMapPro('copy','number',256,'mode1');
%figure('Name','ColorMapPro输出')
%image(permute(map,[1,3,2]))
% map = TheColor('sci',2062);
% map = flipud(map);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 16;
figureHeight = 12;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);

%% 水平三维柱状图绘制
GO = bar3h(ZData,0.5);
hTitle = title(sprintf('Average Monthly Temperatures from %d to %d',YData(1),YData(end)));
hXLabel = xlabel('XAxis');
hYLabel = ylabel('YAxis');
hZLabel = zlabel('ZAxis');
view(-37.5,30)

%% 细节优化
% 赋色
colormap(map)
% 坐标区调整
set(gca, 'Box', 'on', ...                                                           % 边框
         'LineWidth', 1, 'GridLineStyle', '-',...                                   % 坐标轴线宽
         'XGrid', 'on', 'YGrid', 'on','ZGrid', 'on', ...                            % 网格
         'TickDir', 'out', 'TickLength', [.015 .015], ...                           % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off',  'ZMinorTick', 'off',...         % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1], 'ZColor', [.1 .1 .1],...      % 坐标轴颜色
         'Xticklabel',XData,...                                                    % X坐标轴刻度标签
         'Zticklabel',YData)                                % Z坐标轴刻度标签
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 10)
set([hXLabel, hYLabel,hZLabel], 'FontSize', 11, 'FontName', 'Arial')
set(hTitle, 'FontSize', 12, 'FontWeight' , 'bold')
% 背景颜色
set(gcf,'Color',[1 1 1])

%% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'Barh3D';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');