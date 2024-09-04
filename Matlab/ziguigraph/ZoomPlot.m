% Matlab进阶绘图-局部放大图
% 公众号：阿昆的科研日常

%% 数据准备
% 导入数据
load data xfit yfit xdata_m ydata_m ydata_s xVdata yVdata xmodel ymodel ...
    ymodelL ymodelU c cint

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
color_hFit = TheColor('xkcd',346);
color_hModel = TheColor('xkcd',545);
color_hData = TheColor('xkcd',301);
color_hCI1 = TheColor('xkcd',304);
color_hCI2 = TheColor('xkcd',304);
color_hE = TheColor('xkcd',587);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]); % define the new figure dimensions
hold on

%% 绘制
hFit = line(xfit, yfit);
hData = line(xVdata, yVdata);
hModel = line(xmodel, ymodel);
hCI(1) = line(xmodel, ymodelL);
hCI(2) = line(xmodel, ymodelU);
hE = errorbar(xdata_m, ydata_m, ydata_s);
% 添加label
hTitle = title('My Publication-Quality Graphics');
hXLabel = xlabel('Length (m)');
hYLabel = ylabel('Mass (kg)');
% 添加文字注释
hText = text(10, 800, ...
    sprintf('{\\itC = %0.1g \\pm %0.1g (CI)}', c, cint(2)-c));

%% 细节优化
% 赋色
set(hFit, 'Color', color_hFit)
set(hModel, 'Color', color_hModel)
set(hCI(1), 'Color', color_hCI1)
set(hCI(2), 'Color', color_hCI2)
set(hData, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', color_hData)
set(hE, 'Color', color_hE, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , color_hE)
% 设置线属性
set(hFit, 'LineWidth', 1.5)
set(hModel, 'LineStyle', '--', 'LineWidth', 1.5)
set(hCI(1), 'LineStyle', '-.','LineWidth', 1.5)
set(hCI(2), 'LineStyle', '-.','LineWidth', 1.5)
set(hData, 'LineStyle', 'none', 'Marker', '.','Marker', 'o', 'MarkerSize', 5)
set(hE, 'LineStyle', 'none', 'Marker', '.','LineWidth', 1.5, 'Marker', 'o', 'MarkerSize', 6)
% 设置坐标轴属性
set(gca, 'Box', 'off',... 
         'TickDir', 'out', 'TickLength', [.01 .01], ...
         'XMinorTick', 'on', 'YMinorTick', 'on',... 
         'XGrid', 'off', 'YGrid', 'off', ...
         'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3],...
         'YTick', 0:500:2500, ...
         'LineWidth', 1)
% 添加上、右框线
hold on
XL = get(gca,'xlim'); XR = XL(2);
YL = get(gca,'ylim'); YT = YL(2);
xc = get(gca,'XColor');
yc = get(gca,'YColor');
plot(XL,YT*ones(size(XL)),'color', xc,'LineWidth',1)
plot(XR*ones(size(YL)),YL,'color', yc,'LineWidth',1)
% legend
hLegend = legend([hE, hFit, hData, hModel, hCI(1)], ...
    'Data ({\it\mu} \pm {\it\sigma})', 'Fit (C{\itx}^3)', ...
    'Validation Data', 'Model (C{\itx}^3)', '95% CI', ...
    'Location', 'SouthEast');
% 设置字体字号
set(gca, 'FontName', 'Helvetica')
set([hTitle, hXLabel, hYLabel, hText], 'FontName', 'AvantGarde')
set([hLegend, gca], 'FontSize', 8)
set([hXLabel, hYLabel, hText], 'FontSize', 10)
set(hTitle, 'FontSize', 12, 'FontWeight' , 'bold')
% 背景颜色
set(gcf,'Color',[1 1 1])

%% 添加局部放大
zp = BaseZoom();
zp.plot;

%% 图片输出
exportgraphics(figureHandle,'test.png','Resolution',300)