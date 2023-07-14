% 面积图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
% 自变量datax
load datax.mat;
% 因变量datay
load datay.mat;
N = size(datax,1);

%% 颜色定义
% addcolorplus函数获取方式：
% 公众号后台回复：配色强化
map = addcolorplus(296);
idx = linspace(1,64,N);
idx = round(idx);
C = map(idx,:);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 6;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]); % define the new figure dimensions
hold on

%% 面积图绘制
for i = 1:N
    area(datax(i,:),datay(i,:),'LineWidth',2,'FaceColor',C(i,:),'EdgeColor',C(i,:),...
          'FaceAlpha',.3,'EdgeAlpha',1);
    hold on
end
hXLabel = xlabel('Cortical depth(normalized)');
hYLabel = ylabel('Cell density');
%% 细节优化
% 坐标轴美化
set(gca, 'Box', 'off', ...                                         % 边框
         'XGrid', 'off', 'YGrid', 'on', ...                        % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...            % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...             % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...           % 坐标轴颜色
         'XTick', 0:0.1:1.2,...                                    % 刻度与范围
         'XLim', [0 1.1],...
         'YLim', [0 1])

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
