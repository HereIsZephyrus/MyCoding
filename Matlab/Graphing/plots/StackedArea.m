% 面积填充图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load data.mat
% 自变量
x = 1:10;
% 因变量
y = areaData;

%% 颜色定义
% addcolorplus函数获取方式：
% 公众号后台回复：配色强化
idx = linspace(1,64,4); 
idx = round(idx);
map = addcolorplus(300);
C = map(idx,:);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 12;
figureHeight = 8;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

%% 面积填充图绘制
a = area(x, y, 'LineStyle', '-', 'LineWidth', 1);
hTitle = title('Area Plot');
hXLabel = xlabel('XAix');
hYLabel = ylabel('YAix');

%% 细节优化
% 赋色
% colororder(C); 
a(1).FaceColor = C(1,:);
a(2).FaceColor = C(2,:);
a(3).FaceColor = C(3,:);
a(4).FaceColor = C(4,:);
% 坐标区调整
set(gca, 'Box', 'on', ...                                         % 边框
         'LineWidth', 1, 'GridLineStyle', '-',...                 % 线宽线型
         'XGrid', 'off', 'YGrid', 'off', ...                      % 网格
         'TickDir', 'in', 'TickLength', [.005 .005], ...          % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...            % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...          % 线颜色
         'XTick', 0:1:10,...                                      % 坐标区刻度、范围
         'XLim', [1 10],...
         'YTick', 0:50:150,...
         'YLim', [0 150])
% legend
hLegend = legend('set 1', 'set 2', 'set 3', 'set 4','Location', 'northwest');
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