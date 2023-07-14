% 双对数刻度折线图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load data.mat
% 因变量
X = x;
% 自变量
Y1 = y(1,:);
Y2 = y(4,:);
Y3 = y(5,:);
Y4 = y(6,:);
Y5 = y(7,:);

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
C = TheColor('sci',1796);
C1 = C(1,:);
C2 = C(2,:);
C3 = C(3,:);
C4 = C(4,:);
C5 = C(6,:);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);

%% 双对数刻度折线图绘制
LL1 = loglog(X, Y1);
hold on
LL2 = loglog(X, Y2);
LL3 = loglog(X, Y3);
LL4 = loglog(X, Y4);
LL5 = loglog(X, Y5);
hTitle = title('Loglog Plot');
hXLabel = xlabel('Xlabel');
hYLabel = ylabel('Ylabel');

%% 细节优化
% 线属性调整
LW = 2;
set(LL1, 'LineStyle', '-','LineWidth', LW,  'Color', C1)
set(LL2, 'LineStyle', '-','LineWidth', LW,  'Color', C2)
set(LL3, 'LineStyle', '-','LineWidth', LW,  'Color', C3)
set(LL4, 'LineStyle', '-','LineWidth', LW,  'Color', C4)
set(LL5, 'LineStyle', '-','LineWidth', LW,  'Color', C5)
% 坐标区调整
set(gca, 'Box', 'off', ...                                % 边框
         'LineWidth',1,...                                % 线宽
         'XGrid', 'on', 'YGrid', 'on', ...                % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...   % 刻度
         'XMinorTick', 'on', 'YMinorTick', 'on', ...      % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...  % 坐标轴颜色
         'Xlim' ,[0.1 10],'Ylim' ,[0.01 100])             % 坐标轴范围
% 添加上、右框线
XL = get(gca,'xlim'); XR = XL(2);
YL = get(gca,'ylim'); YT = YL(2);
xc = get(gca,'XColor');
yc = get(gca,'YColor');
plot(XL,YT*ones(size(XL)),'color', xc,'linewidth',1)
plot(XR*ones(size(YL)),YL,'color', yc,'linewidth',1)
% 添加图例
hLegend = legend([LL1,LL2,LL3,LL4,LL5], ...
                 'Samp1','Samp2','Samp3','Samp4','Samp5', ...
                 'Location', 'northeast');
P = hLegend.Position;
hLegend.Position = P + [0.001 -0.02 0 0.03];
% 字体和字号
set(gca,'FontName','Arial','FontSize',11)
set([hXLabel,hYLabel,hLegend],'FontName','Arial','FontSize',11)
set(hTitle,'FontName','Arial','FontSize',12)
% 背景颜色
set(gcf,'Color',[1 1 1])

%% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'test';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');