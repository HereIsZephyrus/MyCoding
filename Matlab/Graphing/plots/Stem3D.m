% 三维针状图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
[X,Y] = meshgrid(0:0.13:1);
Z = exp(X+Y);

%% 颜色定义
% colorplus函数获取方式：
% 公众号后台回复：450
C1 = colorplus(27);
C2 = colorplus(54);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

%% 三维针状图绘制
% 定义绘图参数
MarkerType = 'o';
MarkerSize = 8;
LineWidth = 1.2;
LineStyle = '-';
% 绘制
st = stem3(X,Y,Z,...
        'MarkerEdgeColor',C1,...      % 符号轮廓颜色
        'MarkerFaceColor',C2,...      % 符号填充颜色
        'Marker',MarkerType,...       % 符号类型
        'MarkerSize',MarkerSize,...   % 符号尺寸
        'LineWidth',LineWidth,...     % 线宽
        'LineStyle',LineStyle,...     % 线型
        'Color',C1);                  % 线的颜色
hTitle = title('Stem Plot of 3-D Data');
hXLabel = xlabel('Xlabel');
hYLabel = ylabel('Ylabel');
hZLabel = zlabel('Zlabel');

%% 细节优化
% 视角
view(-37.5,30)
% 坐标轴美化
set(gca, 'Box', 'off', ...                                         % 边框
         'XGrid', 'on', 'YGrid', 'on', 'ZGrid', 'on', ...          % 网格
         'TickDir', 'out', 'TickLength', [.015 .015], ...          % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...             % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])              % 坐标轴颜色

% 字体和字号
set(gca, 'FontName', 'Helvetica')
set([hXLabel, hYLabel, hZLabel], 'FontName', 'AvantGarde')
set(gca, 'FontSize', 10)
set([hXLabel, hYLabel, hZLabel], 'FontSize', 11)
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