% 阶梯图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
% 定义自变量
x = linspace(0,4*pi,30)';
% 定义因变量
samp1 = 0.5*cos(x);
samp2 = 1*cos(1.5*x);
samp3 = 1.5*cos(0.5*x);
samp4 = 1.5*cos(x);

%% 颜色定义
% colorplus函数获取方式：
% 公众号后台回复：450
C = colorplus([34 202 83 104]);
C1 = C(1,:);
C2 = C(2,:);
C3 = C(3,:);
C4 = C(4,:);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]); % define the new figure dimensions
hold on

%% 阶梯图绘制
S1 = stairs(x, samp1);
S2 = stairs(x, samp2);
S3 = stairs(x, samp3);
S4 = stairs(x, samp4);
hXLabel = xlabel('Point spacing (m)');
hYLabel = ylabel('MAE (m)');

%% 细节优化
% 定义线宽和颜色(或线型、符号、线宽和颜色)
set(S1, 'LineWidth', 1.5,  'Color', C1)
set(S2, 'LineWidth', 1.5,  'Color', C2)
set(S3, 'LineWidth', 1.5,  'Color', C3)
set(S4, 'LineWidth', 1.5,  'Color', C4)
% set(S1, 'LineStyle', '-', 'Marker', '.', 'MarkerSize', 18, 'LineWidth', 1.5, 'Color', C1)
% set(S2, 'LineStyle', '-', 'Marker', '*', 'LineWidth', 1.5,  'Color', C2)
% set(S3, 'LineStyle', '-', 'Marker', 'o', 'LineWidth', 1.5,  'Color', C3)
% set(S4, 'LineStyle', '-', 'Marker', 's', 'LineWidth', 1.5,  'Color', C4)
% 坐标轴美化
set(gca, 'Box', 'off', ...                                         % 边框
         'XGrid', 'off', 'YGrid', 'on', ...                        % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...            % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...             % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...           % 坐标轴颜色
         'XTick', 0:2:14,...
         'XLim', [0 4*pi],...
         'YTick', -2:0.5:2, ...
         'YLim', [-1.7 2])
ax2 = axes('Position',get(gca,'Position'),...
           'XAxisLocation','top',...
           'YAxisLocation','right',...
           'Color','none',...
           'XColor','k','YColor','k');
set(ax2,'YTick', []);
set(ax2,'XTick', []);
box on
% Legend
hLegend = legend([S1,S2,S3,S4], ...
                 'Samp1', 'Samp2','Samp3','Samp4', ...
                 'Location', 'northeast',...
                 'orientation','horizontal');
% 字体字号
set(gca, 'FontName', 'Arial', 'FontSize', 9)
set([hXLabel,hYLabel,hLegend], 'FontName',  'Arial', 'FontSize', 10)
% 背景颜色
set(gcf,'Color',[1 1 1])

%% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'test2';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');
