% 带缺口的分组箱线图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load data.mat

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
C1 = TheColor('xkcd',426);
C2 = TheColor('xkcd',331);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 12;
figureHeight = 10;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

%% 带缺口的分组箱线图绘制
box_1 = boxplot(group1,'positions',p1,'Colors',C1,'Widths',0.7,...
    'Notch','on','Symbol','o','OutlierSize',5,'Jitter',0);
box_2 = boxplot(group2,'positions',p2,'Colors',C2,'Widths',0.7,...
    'Notch','on','Symbol','o','OutlierSize',5,'Jitter',0);
hTitle = title('Miles per Gallon by Vehicle Origin');
hXLabel = xlabel('Samples');
hYLabel = ylabel('Miles per Gallon (MPG)');

%% 细节优化
% 线宽
set([box_1,box_2],'LineWidth',1.5)
set([box_1(1:2,:),box_2(1:2,:)],'LineStyle','-')
% 坐标轴美化
set(gca, 'Box', 'off', ...                                        % 边框
         'LineWidth', 1,...                                       % 线宽
         'XGrid', 'off', 'YGrid', 'on', ...                       % 网格
         'TickDir', 'out', 'TickLength', [.015 .015], ...         % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...            % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])             % 坐标轴颜色
set(gca, 'XTick', (p1+p2)/2,...
         'XTickLabel', {'Sample1','Sample2','Sample3','Sample4'},...
         'Xlim',[-0.5 11.5],...
         'Ylim',[-4 4]);
% legend
lg = findobj(gca,'Tag', 'Box');
hLegend = legend([lg(5),lg(1)],...
                 'Group1','Group2');
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 9)
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