% 帕累托图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load AircraftAccidents.mat

%% 颜色定义
% addcolorplus函数获取方式：
% 公众号后台回复：配色强化
C1 = addcolorplus(213);
C2 = addcolorplus(160);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 12;
figureHeight = 8;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

%% 帕累托图绘制
[p, ax] = pareto(accidents,issue);                               
hTitle = title('Aircraft Mechnical Accident Trends');
hXLabel = xlabel('Types of Mechnical Issues');
hYLabel = ylabel('Number of Accidents');

%% 细节优化
% 对象属性调整
% 柱属性
p(1).BarWidth = 0.5;
p(1).LineWidth = 1; 
p(1).FaceColor = C1;
p(1).FaceAlpha = 1;
% 折线属性
p(2).LineStyle = '--';         
p(2).LineWidth = 2; 
p(2).Color = C2; 
% 坐标轴美化
set(ax(1), 'Box', 'off', ...                                     % 边框
           'LineWidth',1,...                                     % 线宽
           'XGrid', 'on', 'YGrid', 'on', ...                     % 网格
           'TickDir', 'out', 'TickLength', [.01 .01], ...        % 刻度
           'XMinorTick', 'off', 'YMinorTick', 'off', ...         % 小刻度
           'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])          % 坐标轴颜色

set(ax(2), 'LineWidth',1,...                                     % 线宽
           'TickDir', 'out', 'TickLength', [.01 .01], ...        % 刻度
           'XMinorTick', 'off', 'YMinorTick', 'off', ...         % 小刻度
           'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])          % 坐标轴颜色
% 添加上框线
xc = get(gca,'XColor');
yc = get(gca,'YColor');
unit = get(gca,'units');
AX = axes( 'Units', unit,...
           'Position',get(gca,'Position'),...
           'XAxisLocation','top',...
           'YAxisLocation','right',...
           'Color','none',...
           'XColor',xc,...
           'YColor',yc);
set(AX, 'linewidth',1,...
        'XTick', [],...
        'YTick', []);
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 10)
set([hXLabel, hYLabel], 'FontName', 'Arial', 'FontSize', 11)
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
