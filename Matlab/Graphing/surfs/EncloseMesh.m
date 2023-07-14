% 带帷幕的网格曲面图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
[X,Y] = meshgrid(-3:0.15:3);
Z = peaks(X,Y);

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
map = TheColor('sci',2068);
% map = flipud(map);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 10;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

%% 带帷幕的网格曲面图绘制
mz = meshz(X,Y,Z,Z,'LineWidth',1);
% mz = meshz(X,Y,Z,Z,'LineWidth',1,'FaceAlpha',0);
hTitle = title('Error at the Given Data Sites');
hXLabel = xlabel('x');
hYLabel = ylabel('y');
hZLabel = zlabel('Error');
view(-37.5,30)

%% 细节优化
% 赋色
colormap(map)
colorbar
% 坐标区调整
set(gca, 'Box', 'off', ...                                                          % 边框
         'LineWidth', 1, 'GridLineStyle', '-',...                                   % 坐标轴线宽
         'XGrid', 'on', 'YGrid', 'on','ZGrid', 'on', ...                            % 网格
         'TickDir', 'out', 'TickLength', [.015 .015], ...                           % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off',  'ZMinorTick', 'off',...         % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1], 'ZColor', [.1 .1 .1])         % 坐标轴颜色
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 11)
set([hXLabel,hYLabel,hZLabel], 'FontName',  'Arial', 'FontSize', 11)
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