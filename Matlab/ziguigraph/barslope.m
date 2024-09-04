%% prepare
clc;clear;close all;
slopeRange = {'<=10','10-15','15-20','20-25','>25'};
coverName = {'不透水面','水体','农地','林地'};
periodName = {'2015-2017土地利用类型转移矩阵','2017-2019土地利用类型转移矩阵'};

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
C1 = TheColor('xkcd',426);
C2 = TheColor('xkcd',627);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 12;
figureHeight = 10;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]); % define the new figure dimensions
hold on

%% 双向柱状图绘制
GO1 = bar(X,Y1,0.6,'EdgeColor','k','LineWidth',1);
GO2 = bar(X,Y2,0.6,'EdgeColor','k','LineWidth',1);
hTitle = title('Bidirectional bar chart');
hXLabel = xlabel('Xaxis');
hYLabel = ylabel('Yaxis');

%% 细节优化
% 赋色
GO1.FaceColor = C1;
GO2.FaceColor = C2;
% 基线调整
BL = get(GO2,'BaseLine');
BL.LineWidth = 1;
% 坐标区调整
set(gca, 'Box', 'off', ...                                         % 边框
         'LineWidth', 1, 'GridLineStyle', '-',...                  % 坐标轴线宽
         'XGrid', 'off', 'YGrid', 'on', ...                        % 网格
         'TickDir', 'out', 'TickLength', [.015 .015], ...          % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...             % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])              % 坐标轴颜色
set(gca, 'XTick', 1:6,...
         'Xlim' , [0.5 6.5], ... 
         'Xticklabel',{'A','B','C','D','E','F'},...
         'YTick', -8000:4000:12000)
% Legend
hLegend = legend([GO1,GO2], ...
                 'Income','Payout', ...
                 'Location', 'northeast');
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 10)
set([hLegend,hXLabel,hYLabel], 'FontSize', 11, 'FontName', 'Arial')
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