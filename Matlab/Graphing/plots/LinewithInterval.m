% 带置信区间的折线图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 数据构造方法参考
% x1 = 0:0.01:10;
% y1 = besselj(1,x1);
% x2 = 0:0.01:10;
% y2 = besselj(3,x2)-0.1;
% x3 = 0:0.01:10;
% y3 = besselj(6,x3)-0.2;
% xconf1 = [x1 x1(end:-1:1)];
% yconf1 = [y1+0.15 y1(end:-1:1)-0.15];
% xconf2 = [x2 x2(end:-1:1)];
% yconf2 = [y2+0.05 y2(end:-1:1)-0.05];
% xconf3 = [x1 x1(end:-1:1)];
% yconf3 = [y3+0.05 y3(end:-1:1)-0.05];

% 读取数据
load data.mat

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
C = TheColor('xkcd',[384 66 627]);
C1 = C(1,1:3);
C2 = C(2,1:3);
C3 = C(3,1:3);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

%% 带置信区间的折线图绘制
P1 = fill(xconf1,yconf1,C1);
P2 = fill(xconf2,yconf2,C2);
P3 = fill(xconf3,yconf3,C3);
L1 = line(x1,y1);
L2 = line(x2,y2);
L3 = line(x3,y3);
hTitle = title('Line Chart with Confidence Interval');
hXLabel = xlabel('GlobBiomass AGB');
hYLabel = ylabel('AGB');

%% 细节优化
% 赋色及属性调整
% 灰色填充
% set(P1,'FaceColor',[0.5 0.5 0.5],'FaceAlpha',0.2,'EdgeColor','none')
% set(P2,'FaceColor',[0.5 0.5 0.5],'FaceAlpha',0.2,'EdgeColor','none')
% set(P3,'FaceColor',[0.5 0.5 0.5],'FaceAlpha',0.2,'EdgeColor','none')
% 彩色填充
set(P1,'FaceColor',C1,'FaceAlpha',0.3,'EdgeColor','none')
set(P2,'FaceColor',C2,'FaceAlpha',0.3,'EdgeColor','none')
set(P3,'FaceColor',C3,'FaceAlpha',0.3,'EdgeColor','none')
set(L1,'LineStyle','-','LineWidth',3, 'Color',C1)
set(L2,'LineStyle','-','LineWidth',3, 'Color',C2)
set(L3,'LineStyle','-','LineWidth',3, 'Color',C3)
% 坐标区调整
set(gca, 'Box', 'off', ...                                % 边框
         'Layer','top',...                                % 图层
         'LineWidth',1,...                                % 线宽
         'XGrid', 'off', 'YGrid', 'on', ...               % 网格
         'TickDir', 'out', 'TickLength', [0.01 0.01], ... % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...    % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])     % 坐标轴颜色
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
% Legend
hLegend = legend([L1,L2,L3,], ...
                 'Samp1', 'Samp2','Samp3', ...
                 'Location', 'northeast');
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 10)
set([hLegend,hXLabel,hYLabel], 'FontSize', 11, 'FontName', 'Arial')
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