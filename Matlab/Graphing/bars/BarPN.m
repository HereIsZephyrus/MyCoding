% 正负柱状图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load data.mat
% 初始化数据
flag1 = 1;
flag2 = 1;
for i = 1:length(dataset)
    if dataset(i)<0
        xn(flag1) = x(i);
        yn(flag1) = dataset(i);
        flag1 = flag1 + 1;
    else
        xp(flag2) = x(i);
        yp(flag2) = dataset(i);
        flag2 = flag2 + 1;
    end
end

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
C = TheColor('xkcd',[426 260]);
C1 = C(1,:);
C2 = C(2,:);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 12;
figureHeight = 10;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

%% 正负柱状图绘制
GOP = bar(xp,yp,0.7,'EdgeColor','k','LineWidth',0.7);
GON = bar(xn,yn,0.7,'EdgeColor','k','LineWidth',0.7);
hTitle = title('P/N bar chart');
hXLabel = xlabel('Xaxis');
hYLabel = ylabel('Yaxis');

%% 细节优化
% 赋色
set(GOP,'FaceColor',C1,'FaceAlpha',0.8)
set(GON,'FaceColor',C2,'FaceAlpha',0.8)
% 基线调整
BL = get(GOP,'BaseLine');
BL.LineWidth = 0.7;
% 坐标区调整
set(gca, 'Box', 'off', ...                                         % 边框
         'LineWidth', 1, 'GridLineStyle', '-',...                  % 坐标轴线宽
         'XGrid', 'on', 'YGrid', 'on', ...                         % 网格
         'TickDir', 'out', 'TickLength', [.015 .015], ...          % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...             % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])              % 坐标轴颜色
% Legend
hLegend = legend([GOP,GON], ...
                 'True','False', ...
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