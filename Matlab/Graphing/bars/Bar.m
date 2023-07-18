clc;clear;close all;
%% 数据准备
% 读取数据
% 自变量
x = 1:10;
% 因变量
dataset = [0.341,0.493,0.324,0.428,0.333,0.341,0.493,0.324,0.428,0.333];

%% 颜色定义
map = addcolorplus(296);
idx = linspace(1,64,10);
idx = round(idx);
C = map(idx,:);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 8;
figureHeight = 10;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]); % define the new figure dimensions
hold on

%% 绘制多色单组柱状图
GO = bar(x,dataset,0.6,'EdgeColor','k','LineWidth', 1);
hXLabel = xlabel('XAxis');
hYLabel = ylabel('YAxis');

%% 细节优化
% 赋色
GO.FaceColor = 'flat';
for i = 1:10
    GO.CData(i,:) = C(i,:);
end

% 坐标区调整
set(gca, 'Box', 'off', ...                                         % 边框
         'LineWidth', 1, 'GridLineStyle', '-',...                  % 坐标轴线宽
         'XGrid', 'off', 'YGrid', 'off', ...                       % 网格
         'TickDir', 'out', 'TickLength', [.015 .015], ...          % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...             % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...           % 坐标轴颜色
         'YTick', 0:0.1:1,...                                      % 刻度位置、间隔、范围
         'Ylim' , [0 0.6], ...                                     
         'Xlim' , [0.3 10.7], ...
         'XTick', 1:10,...
         'Xticklabel',{1:10},...                                   % X坐标轴刻度标签
         'Yticklabel',{0:0.1:1})                                 % Y坐标轴刻度标签

% 字体和字号
set(gca, 'FontName', 'Helvetica')
set([hXLabel, hYLabel], 'FontName', 'AvantGarde')
set(gca, 'FontSize', 10)
set([hXLabel, hYLabel], 'FontSize', 12)

% 背景颜色
set(gcf,'Color',[1 1 1])

%% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'Bar';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');