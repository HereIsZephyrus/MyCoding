% 进阶折线图绘制模板
% By：阿昆的科研日常

%% 数据准备
% 导入数据
load data xfit yfit xdata_m ydata_m ydata_s xVdata yVdata xmodel ymodel ...
    ymodelL ymodelU c cint

%% 颜色定义
% addcolorplus函数获取方式：
% 公众号后台回复：配色强化
color_hFit = addcolorplus(1);
color_hModel = addcolorplus(168);
color_hData = addcolorplus(140);
color_hCI1 = addcolorplus(136);
color_hCI2 = addcolorplus(136);
color_hE = addcolorplus(93);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]); % define the new figure dimensions
hold on

%% 进阶折线图绘制
% 绘制初始折线图
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
         'TickDir', 'out', 'TickLength', [.02 .02], ...
         'XMinorTick', 'on', 'YMinorTick', 'on',... 
         'XGrid', 'off', 'YGrid', 'on', ...
         'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3],...
         'YTick', 0:500:2500, ...
         'LineWidth', 1)
% legend
hLegend = legend([hE, hFit, hData, hModel, hCI(1)], ...
    'Data ({\it\mu} \pm {\it\sigma})', 'Fit (C{\itx}^3)', ...
    'Validation Data', 'Model (C{\itx}^3)', '95% CI', ...
    'Location', 'NorthWest');
% 设置字体字号
set(gca, 'FontName', 'Helvetica')
set([hTitle, hXLabel, hYLabel, hText], 'FontName', 'AvantGarde')
set([hLegend, gca], 'FontSize', 8)
set([hXLabel, hYLabel, hText], 'FontSize', 10)
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