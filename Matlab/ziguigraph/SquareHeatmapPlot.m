% Matlab进阶绘图-方块热图
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load data.mat
% 数据矩阵
Z = data;

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
map = TheColor('sci',2064);
% map = flipud(map);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);

%% 方块热图绘制
squareheatmap(Z,1000)
hTitle = title('Square Heatmap Plot');
hXLabel = xlabel('K (w)');
hYLabel = ylabel('Samples');

%% 细节优化
% 赋色
colormap(map)
colorbar
% 坐标区调整
axis equal tight
set(gca, 'Box', 'off', ...                                % 边框
         'Layer','bottom',...                             % 图层
         'LineWidth',1,...                                % 线宽
         'XGrid', 'off', 'YGrid', 'off', ...              % 网格
         'TickDir', 'out', 'TickLength', [0 0], ...       % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...    % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...  % 坐标轴颜色
         'xtick',1:10,...                                 % 坐标轴刻度
         'xticklabels',1:10,...
         'ytick',1:10,...
         'yticklabels',1:10)
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 10)
set([hXLabel, hYLabel], 'FontSize', 11, 'FontName', 'Arial')
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