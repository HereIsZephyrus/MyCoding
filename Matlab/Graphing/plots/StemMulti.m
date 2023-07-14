% 多组针状图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load filterData.mat
% 定义自变量
X1 = time;
X2 = time - 0.2;
X3 = time - 0.4;
% 定义因变量
Y1 = signal;
Y2 = filter1;
Y3 = filter2;

%% 颜色定义
% colorplus函数获取方式：
% 公众号后台回复：450
C1 = colorplus(53);
C2 = colorplus(365);
C3 = colorplus(442);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 12;
figureHeight = 9;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

%% 多组针状图绘制
% 定义绘图参数
MarkerType = 'o';
MarkerSize = 5;
LineWidth = 1.5;
LineStyle = '-';
% 绘制
st1 = stem(X1,Y1,...
    'MarkerEdgeColor',C1,...      % 符号轮廓颜色
    'MarkerFaceColor',C1,...      % 符号填充颜色
    'Marker',MarkerType,...       % 符号类型
    'MarkerSize',MarkerSize,...   % 符号尺寸
    'LineWidth',LineWidth,...     % 线宽
    'LineStyle',LineStyle,...     % 线型
    'Color',C1);                  % 线的颜色
hold on
st2 = stem(X2,Y2,...
    'MarkerEdgeColor',C2,...      % 符号轮廓颜色
    'MarkerFaceColor',C2,...      % 符号填充颜色
    'Marker',MarkerType,...       % 符号类型
    'MarkerSize',MarkerSize,...   % 符号尺寸
    'LineWidth',LineWidth,...     % 线宽
    'LineStyle',LineStyle,...     % 线型
    'Color',C2);                  % 线的颜色
st3 = stem(X3,Y3,...
    'MarkerEdgeColor',C3,...      % 符号轮廓颜色
    'MarkerFaceColor',C3,...      % 符号填充颜色
    'Marker',MarkerType,...       % 符号类型
    'MarkerSize',MarkerSize,...   % 符号尺寸
    'LineWidth',LineWidth,...     % 线宽
    'LineStyle',LineStyle,...     % 线型
    'Color',C3);                  % 线的颜色
hTitle = title('MultipleStem Plot of 2-D Data');
hXLabel = xlabel('Samples');
hYLabel = ylabel('Amplitude');

%% 细节优化
% 坐标轴美化
set(gca, 'Box', 'on', ...                                         % 边框
         'XGrid', 'off', 'YGrid', 'off', ...                      % 网格
         'TickDir', 'in', 'TickLength', [.015 .015], ...          % 刻度
         'XMinorTick', 'on', 'YMinorTick', 'on', ...              % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...          % 坐标轴颜色
         'XTick', -1:1:10,...                                     % 坐标区刻度、范围
         'XLim', [-1 9.5],...
         'YTick', -1.2:0.2:1.2,...
         'YLim', [-1.2 1.2])
legend([st1,st2,st3],...
    'Input Signal', 'Input Delayed by 0.2', 'Input Delayed by 0.4',...
    'Location', 'SouthWest')
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