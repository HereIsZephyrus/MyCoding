% 气泡图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load data.mat
% x坐标
xx = data(:,1);
% y坐标
yy = data(:,2);
% 特征（特征大小对应颜色/点的尺寸）
sz = data(:,3);

%% 颜色定义
% addcolorplus函数获取方式：
% 公众号后台回复：配色强化
map = addcolorplus(300);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 20;
figureHeight = 12;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

%% 气泡图绘制
bubblechart(xx, yy, sz, sz,'MarkerFaceAlpha',0.7);
hTitle = title('BubbleChart');
hXLabel = xlabel('XAxis');
hYLabel = ylabel('YAxis');

%% 细节优化
% 赋色
colormap(map)
% 坐标轴美化
set(gca, 'Box', 'on', ...                                        % 边框
         'XGrid', 'off', 'YGrid', 'off', ...                     % 网格
         'TickDir', 'in', 'TickLength', [.01 .01], ...           % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...           % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...         % 坐标轴颜色
         'XTick', 0:2:24,...                                     % 坐标区刻度、范围
         'XLim', [0 23],...
         'YTick', 0:0.2:1.2,...
         'YLim', [0 1.2])
% 添加图例
blgd = bubblelegend('Style','vertical',...
    'BubbleSizeOrder','descending',...
    'box','off',...
    'Location','northeastoutside',...
    'NumBubbles',3,... ...
    'FontName', 'Helvetica',...
    'FontSize', 9);
colorbar('Position',[0.79,0.11,0.03,0.4])
% 字体和字号
set(gca, 'FontName', 'Helvetica')
set([hXLabel, hYLabel], 'FontName', 'AvantGarde')
set(gca, 'FontSize', 10)
set([hXLabel, hYLabel], 'FontSize', 11)
set(hTitle, 'FontSize', 12, 'FontWeight' , 'bold')
% 背景颜色
set(gcf,'Color',[1 1 1])

%% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'test';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');
