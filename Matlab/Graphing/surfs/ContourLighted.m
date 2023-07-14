% 带等高线的光影曲面图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load data.mat
[X,Y] = meshgrid(xi,yi);
Z = DSM;

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
map = TheColor('sci',2073);
% map = flipud(map);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 10;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

%% 带等高线的光影曲面图绘制
s = surfc(X,Y,Z);
hTitle = title('SurfaceLight&Contour Plot');
hXLabel = xlabel('x');
hYLabel = ylabel('y');
hZLabel = zlabel('z');
view(-28.9,39.0)

%% 细节优化
% 赋色
colormap(map)
colorbar
% 添加光影效果
% Shadow函数获取方式：
% 公众号后台回复：光影
Shadow([-60,70],'dull','phong')
% 线、面属性调整
s(1).EdgeColor = 'none';
s(2).LevelStep = 20;
s(2).LineWidth = 1;
s(2).ZLocation = 'zmin';
% 坐标区调整
axis tight
set(gca, 'Box', 'off', ...                                                          % 边框
         'LineWidth', 1, 'GridLineStyle', '-',...                                   % 坐标轴线宽
         'XGrid', 'on', 'YGrid', 'on', 'ZGrid', 'on',...                            % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...                             % 刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],'ZColor', [.1 .1 .1],...       % 坐标轴颜色
         'Zlim',[-1500 300])
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