%% 数据准备
% 读取数据
% 自变量
x = 1:7;
% 因变量
y = [87687 9229 1387 1066 447 147 26];

%% 颜色定义
C=addcolorplus(296);
% 对比色
%C = TheColor('sci',999);
% 渐变色
% C = TheColor('sci',2064,'map',7);
% C = flipud(C);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 10;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]); % define the new figure dimensions
hold on

%% 对数刻度横向柱状图绘制
GO = barh(x,y,0.9,'EdgeColor','k','LineWidth',1);
hTitle = title('Horizontal bar chart with logarithmic scale');
hXLabel = xlabel('XAxis');
hYLabel = ylabel('YAxis');

%% 细节优化
% 赋色
GO.FaceColor = 'flat';
n=length(x);
for i = 1:n
    GO.CData(i,:) = C(floor(length(C)/n*i),:);
end
clear n;
% 坐标区调整
set(gca, 'Box', 'off', ...                                         % 边框
         'LineWidth',1,...                                         % 线宽
         'XGrid', 'on', 'YGrid', 'off', ...                        % 网格
         'TickDir', 'out', 'TickLength', [.015 .015], ...          % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...             % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...           % 坐标轴颜色
         'XScale','log','YScale','linear',...                      % 坐标轴刻度类型
         'YDir','reverse',...
         'YTick',1:7,...
         'YLim',[0.3,7.7],...
         'Yticklabel',{'LP','NW','MP','KZN','NC','GP','WC'}) 
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
% 字体字号
set(gca, 'FontName', 'Arial', 'FontSize', 10)
set([hXLabel,hYLabel], 'FontName',  'Arial', 'FontSize', 10)
set(hTitle, 'FontSize', 11, 'FontWeight' , 'bold')
% 背景颜色
set(gcf,'Color',[1 1 1])

%% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'BarhLog';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');