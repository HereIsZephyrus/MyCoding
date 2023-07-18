% 三维箭头图绘制模板
% By：阿昆的科研日常

%% 数据准备
% 读取数据
load data.mat
% 初始化参数
X = x;
Y = y;
Z = z;
U = u;
V = v;
W = z;

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
C = TheColor('xkcd',41);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 16;
figureHeight = 14;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);

%% 三维箭头图绘制
q = quiver3(X, Y, Z, U, V, W);
hTitle = title('Turbulence Values');
hXLabel = xlabel('xaxis');
hYLabel = ylabel('yaxis');
hZLabel = zlabel('zaxis');
view(-26,24)

%% 细节优化
% 线型调整
q.Color = C;
q.LineWidth = 1;
q.ShowArrowHead  = 'on';
% 坐标区调整
set(gca, 'Box','off',...                                                 % 边框
         'LineWidth',1,...                                               % 线宽
         'XGrid','on','YGrid','on','ZGrid','on',...                      % 网格
         'TickDir','out','TickLength',[.01 .01],...                      % 刻度
         'XMinorTick','off','YMinorTick','off','ZMinorTick','off', ...   % 小刻度
         'XColor',[.1 .1 .1],'YColor',[.1 .1 .1],'ZColor',[.1 .1 .1])    % 坐标轴颜色
% 坐标刻度范围调整
axis([-1 1 -1 1 -1 1])
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 10)
set([hXLabel, hYLabel, hZLabel], 'FontSize', 11, 'FontName', 'Arial')
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