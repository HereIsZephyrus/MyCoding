clc;clear;close all;
%% 数据准备
x = [1980 1990 2000];
y = [50 63 52; 
     55 50 48; 
     30 20 44];

%% 颜色定义
C1 = addcolorplus(193);
C2 = addcolorplus(194);
C3 = addcolorplus(195);

%% 图片尺寸设置
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 8;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]); % define the new figure dimensions
hold on

%% 绘制条形图
GO = barh(x,y,0.8,'EdgeColor','k');
xlabel('XAxis');
ylabel('YAxis');

GO(1).FaceColor = C1;
GO(2).FaceColor = C2;
GO(3).FaceColor = C3;

%% 坐标区调整
set(gca, 'Box', 'off', ...                                         % ±ß¿ò
         'XGrid', 'off', 'YGrid', 'off', ...                       % Íø¸ñ
         'TickDir', 'out', 'TickLength', [.01 .01], ...            % ¿Ì¶È
         'XMinorTick', 'off', 'YMinorTick', 'off', ...             % Ð¡¿Ì¶È
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...           % ×ø±êÖáÑÕÉ«
         'YTick', 1980:10:2000,...                                 % ¿Ì¶ÈÎ»ÖÃ¡¢¼ä¸ô
         'Xticklabel',{0:10:70},...                                % X×ø±êÖá¿Ì¶È±êÇ©
         'Yticklabel',{[1980:10:2000]})                            % Y×ø±êÖá¿Ì¶È±êÇ© 

hLegend = legend([GO(1),GO(2),GO(3)], ...
                 'Legend1','Legend2','Legend3', ...
                 'Location', 'northeast');

% 字体字号
set(gca, 'FontName', 'Arial', 'FontSize', 10)

% 背景颜色
set(gca,'Color',[1 1 1])

%% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'Barh';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');