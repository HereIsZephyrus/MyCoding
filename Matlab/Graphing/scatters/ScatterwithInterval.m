% 带置信区间的折线散点图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 数据构造方法参考
% x=0:0.01:1;
% y1=3.4+28*x-75*x.^3+normrnd(0,5,size(x));
% [p1,s1]=polyfit(x,y1,3);
% y11=polyval(p1,x);
% [yfit1,dy1]=polyconf(p1,x,s1,'alpha',0.05);
% xconfu1 = fliplr(x);
% yconfu1 = fliplr(yfit1+dy1);
% xconfd1 = x;
% yconfd1 = yfit1-dy1;
% y2=-50.6+70*x+normrnd(0,5,size(x));
% [p2,s2]=polyfit(x,y2,1);
% y22=polyval(p2,x);
% [yfit2,dy2]=polyconf(p2,x,s2,'alpha',0.05);
% xconfu2 = fliplr(x);
% yconfu2 = fliplr(yfit2+dy2);
% xconfd2 = x;
% yconfd2 = yfit2-dy2;

% 读取数据
load data.mat

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
C = TheColor('xkcd',[426 627]);
C1 = C(1,1:3);
C2 = C(2,1:3);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

%% 带置信区间的折线散点图绘制
P1 = fill([xconfu1,xconfd1],[yconfu1,yconfd1],C1);
P2 = fill([xconfu2,xconfd2],[yconfu2,yconfd2],C2);
L1 = line(x,y11);
L2 = line(x,y22);
S1 = scatter(x,y1,40,'filled');
S2 = scatter(x,y2,40,'filled');
hTitle = title('Line-Scatter Chart with Confidence Interval');
hXLabel = xlabel('GlobBiomass AGB');
hYLabel = ylabel('AGB');

%% 细节优化
% 赋色及属性调整
set(P1,'FaceColor',[0.5 0.5 0.5],'FaceAlpha',0.2,'EdgeColor','none')
set(P2,'FaceColor',[0.5 0.5 0.5],'FaceAlpha',0.2,'EdgeColor','none')
set(L1,'LineStyle','-','LineWidth',3, 'Color',C1)
set(L2,'LineStyle','-','LineWidth',3, 'Color',C2)
set(S1,'MarkerFaceColor',C1,'MarkerEdgeColor','none')
set(S2,'MarkerFaceColor',C2,'MarkerEdgeColor','none')
% 坐标区调整
set(gca, 'Box', 'off', ...                                % 边框
         'Layer','top',...                                % 图层
         'LineWidth',1,...                                % 线宽
         'XGrid', 'off', 'YGrid', 'on', ...               % 网格
         'TickDir', 'out', 'TickLength', [0.01 0.01], ... % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...    % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])     % 坐标轴颜色
set(gca, 'XLim',[-0.01 1.01],...
         'YLim',[-65 30])
% Legend
hLegend = legend([S1,S2,L1,L2], ...
                 'Data1','Data2','Fit1','Fit2', ...
                 'Location', 'southeast',...
                 'NumColumns',2);
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