% 基础散点图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load data.mat

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 12;
figureHeight = 8;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

%% 基础散点图绘制
scatter(x, y, 3, 'k', 'filled')
hTitle = title('Satellite-derived bathymetry');
hXLabel = xlabel('ICESat-2 bathymetric points in depth (m)');
hYLabel = ylabel('Estimated depth (m)');

%% 细节优化
% 坐标轴美化
set(gca, 'Box', 'on', ...                                         % 边框
         'XGrid', 'off', 'YGrid', 'off', ...                      % 网格
         'TickDir', 'in', 'TickLength', [.015 .015], ...          % 刻度
         'XMinorTick', 'on', 'YMinorTick', 'on', ...              % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...          % 坐标轴颜色
         'XTick', 0:40:160,...                                    % 坐标区刻度、范围
         'XLim', [0 160],...
         'YTick', 0:40:160,...
         'YLim', [0 160])

% 字体和字号
set(gca, 'FontName', 'Helvetica')
set([hXLabel, hYLabel], 'FontName', 'AvantGarde')
set(gca, 'FontSize', 10)
set([hXLabel, hYLabel], 'FontSize', 11)
set(hTitle, 'FontSize', 11, 'FontWeight' , 'bold')

% 背景颜色
set(gcf,'Color',[1 1 1])

%% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'test';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');
