% 带误差棒的折线图绘制模板
% By：阿昆的科研日常

%% 数据准备
% 读取数据
% 自变量
x = 0:10:50;
% 因变量
y = [0 08 15 25 30 32
     0 01 03 05 12 25
     0 15 22 36 38 42];
err = [0.1 1.7 2.6 3.2 2.5 3.2
       0.2 1.8 3.0 2.5 3.5 2.2
       0.1 2.0 2.5 2.2 2.8 2.2];

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
C = TheColor('xkcd',[384 627 66]);
C1 = C(1,:);
C2 = C(2,:);
C3 = C(3,:);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 12;
figureHeight = 10;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]); % define the new figure dimensions
hold on

%% 带误差棒的折线图绘制
E1 = errorbar(x,y(1,:),err(1,:));
E2 = errorbar(x,y(2,:),err(2,:));
E3 = errorbar(x,y(3,:),err(3,:));
hTitle = title('Errorbar Plot');
hXLabel = xlabel('XAxis');
hYLabel = ylabel('YAxis');

%% 细节优化
% 线属性调整
set(E1,  'LineStyle', '-', 'Color', C1,...
         'LineWidth', 3, 'Marker', 'o', 'MarkerSize', 8, ...
         'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , C1)
set(E2,  'LineStyle', '-', 'Color', C2,...
         'LineWidth', 3, 'Marker', 'o', 'MarkerSize', 8, ...
         'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , C2)
set(E3,  'LineStyle', '-', 'Color', C3,...
         'LineWidth', 3, 'Marker', 'o', 'MarkerSize', 8, ...
         'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , C3)
% 坐标轴美化
set(gca, 'Box', 'off', ...                                 % 边框
         'LineWidth',1,...                                 % 线宽
         'XGrid', 'off', 'YGrid', 'on', ...                % 网格
         'TickDir', 'out', 'TickLength', [.015 .015], ...  % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...     % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...   % 坐标轴颜色
         'XTick', 0:10:50,...                              % 坐标轴刻度
         'XLim', [-2 52],...
         'YTick', 0:10:70,...
         'YLim', [-5 50])
% 添加上、右框线
XL = get(gca,'xlim'); XR = XL(2);
YL = get(gca,'ylim'); YT = YL(2);
xc = get(gca,'XColor');
yc = get(gca,'YColor');
plot(XL,YT*ones(size(XL)),'color', xc,'linewidth',1)
plot(XR*ones(size(YL)),YL,'color', yc,'linewidth',1)
% 添加图例
hLegend = legend([E1,E2,E3], ...
                 'Samp1', 'Samp2','Samp3', ...
                 'Location', 'northwest');
P = hLegend.Position;
hLegend.Position = P + [0.015 -0.05 0 0.05];
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 10)
set([hLegend, hXLabel, hYLabel], 'FontSize', 11, 'FontName', 'Arial')
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