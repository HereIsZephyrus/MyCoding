% 等高线图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load data.mat
[X,Y] = meshgrid(xi,yi);
Z = DSM;

%% 颜色定义
% addcolorplus函数获取方式：
% 公众号后台回复：配色强化
map = addcolorplus(300);
% map = flipud(map);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 12;
figureHeight = 11;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);

%% 绘制等高线图
h = contour(X, Y, Z, 10, 'LineWidth',1.2);
hTitle = title('Contour Plot');
hXLabel = xlabel('XAxis');
hYLabel = ylabel('YAxis');

%% 细节优化
% 赋色
colormap(map)
% 坐标轴美化
axis equal
set(gca, 'Box', 'off', ...                                        % 边框
         'LineWidth', 1,...                                       % 线宽
         'XGrid', 'off', 'YGrid', 'off', ...                      % 网格
         'TickDir', 'out', 'TickLength', [.015 .015], ...         % 刻度
         'XMinorTick', 'on', 'YMinorTick', 'on', ...              % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])             % 坐标轴颜色
% 添加上、右框线
hold on
XL = get(gca,'xlim'); XR = XL(2);
YL = get(gca,'ylim'); YT = YL(2);
xc = get(gca,'XColor');
yc = get(gca,'YColor');
plot(XL,YT*ones(size(XL)),'color', xc,'LineWidth',1)
plot(XR*ones(size(YL)),YL,'color', yc,'LineWidth',1)
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