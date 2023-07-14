% Matlab进阶绘图-山脊图
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load data.mat
% 自变量
X = x;
% 因变量
Y = data;

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
map = TheColor('sci',2064);
map = flipud(map);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 11;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);

%% 山脊图绘制
JoyPlot(data',x,0.7, ...
       'constant', ...
        false,...
       'LineWidth',1.2, ...
       'FaceColor','position', ...
       'FaceAlpha',0.8)
hTitle = title('Ridgeline Plot');
hXLabel = xlabel('K (w)');
hYLabel = ylabel('Samples');

%% 细节优化
% 赋色
colormap(map)
% 坐标区调整
% Y刻度标签定义
temp = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
ylbs = sprintfc('Samp %c',temp(1:10));
set(gca, 'Box', 'off', ...                                % 边框
         'LineWidth',1,...                                % 线宽
         'XGrid', 'off', 'YGrid', 'off', ...              % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...   % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...    % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...  % 坐标轴颜色
         'ylim',[-0.3 7.5],...
         'yticklabels',ylbs)
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 10)
set([hXLabel, hYLabel], 'FontSize', 11, 'FontName', 'Arial')
set(hTitle, 'FontSize', 12, 'FontWeight' , 'bold')
% 背景颜色
set(gcf,'Color',[1 1 1])
% 添加上、右框线
xc = get(gca,'XColor');
yc = get(gca,'YColor');
unit = get(gca,'units');
ax = axes( 'Units', unit,...
           'Position',get(gca,'Position'),...
           'XAxisLocation','top',...
           'YAxisLocation','right',...
           'Color','none',...
           'XColor',xc,...
           'YColor',yc);
set(ax, 'linewidth',1,...
        'XTick', [],...
        'YTick', []);

%% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'test';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');
