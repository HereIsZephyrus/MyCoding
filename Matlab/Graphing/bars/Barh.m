% 横向柱状图绘制模板
% By：阿昆的科研日常

%% 数据准备
% 读取数据
% 自变量x
x = [1980 1990 2000];
% 因变量y
y = [50 63 52; 
     55 50 48; 
     30 20 44];

%% 颜色定义
% addcolorplus函数获取方式：
% 公众号后台回复：配色强化
C1 = addcolorplus(193);
C2 = addcolorplus(194);
C3 = addcolorplus(195);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 8;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]); % define the new figure dimensions
hold on

%% 横向柱状图绘制
% 原始横向柱状图
GO = barh(x,y,0.8,'EdgeColor','k');
xlabel('Snowfall')
ylabel('Year')

% 赋色
GO(1).FaceColor = C1;
GO(2).FaceColor = C2;
GO(3).FaceColor = C3;

%% 细节优化
set(gca, 'Box', 'off', ...                                         % 边框
         'XGrid', 'off', 'YGrid', 'off', ...                       % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...            % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...             % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...           % 坐标轴颜色
         'YTick', 1980:10:2000,...                                 % 刻度位置、间隔
         'Xticklabel',{0:10:70},...                                % X坐标轴刻度标签
         'Yticklabel',{[1980:10:2000]})                            % Y坐标轴刻度标签 

hLegend = legend([GO(1),GO(2),GO(3)], ...
                 'Springfield','Fairview','Bristol', ...
                 'Location', 'northeast');

% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 10)

% 背景颜色
set(gca,'Color',[1 1 1])

%% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'test';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');