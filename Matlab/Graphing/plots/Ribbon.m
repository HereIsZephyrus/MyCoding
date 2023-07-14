% 条带图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load data.mat
[x,y] = meshgrid(xi,yi);
inter1 = 1:10:243;
inter2 = 1:10:255;
X = x(inter1,inter2);
Y = y(inter1,inter2);
Z = DSM(inter1,inter2);

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
map = TheColor('sci',2073);
% map = flipud(map);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 20;
figureHeight = 15;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

%% 条带图绘制
r = ribbon(Y,Z,0.7);
hTitle = title('Ribbon Plot');
hXLabel = xlabel('x');
hYLabel = ylabel('y');
hZLabel = zlabel('z');
view(-60,64)

%% 细节优化
% 赋色
colormap(map)
colorbar
% 条带样式调整
% set(r, {'CData'}, get(r,'ZData'),...
%     'FaceColor','interp',...
%     'MeshStyle','column'); 
set(r, {'CData'}, get(r,'ZData'),...
    'FaceColor','interp'); 
% 坐标区调整
set(gca, 'Box', 'off', ...                                                          % 边框
         'LineWidth', 1, 'GridLineStyle', '-',...                                   % 坐标轴线宽
         'XGrid', 'on', 'YGrid', 'on', 'ZGrid', 'on',...                            % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...                             % 刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],'ZColor', [.1 .1 .1])          % 坐标轴颜色
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