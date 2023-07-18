% 分组散点图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load data.mat
% 初始化参数
x = X(:,1);
y = X(:,2);
clusters = idx;
markers = {'^','s','o'};

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
C = TheColor('sci',500);
C1 = C(1,:);
C2 = C(3,:);
C3 = C(4,:);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 16;
figureHeight = 14;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

%% 分组散点图绘制
for i = 1:3
    temp = find(idx==i);
    xtemp = x(temp,1);
    ytemp = y(temp,1);
    S(i) = scatter(xtemp, ytemp, 50, markers{i},'filled');
end
hTitle = title('Grouped Scatter chart');
hXLabel = xlabel('Xaxis');
hYLabel = ylabel('Yaxis');

%% 细节优化
% 赋色
set(S(1),'MarkerFaceColor',C1)
set(S(2),'MarkerFaceColor',C2)
set(S(3),'MarkerFaceColor',C3)
% 坐标区调整
set(gca, 'Box', 'off', ...                                         % 边框
         'LineWidth', 1, 'GridLineStyle', '-',...                  % 坐标轴线宽
         'XGrid', 'on', 'YGrid', 'on', ...                         % 网格
         'TickDir', 'out', 'TickLength', [.015 .015], ...          % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...             % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])              % 坐标轴颜色
% Legend
hLegend = legend([S(1),S(2),S(3)], ...
                 'Cluster1','Cluster2', 'Cluster3',...
                 'Location', 'northwest');
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 11)
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