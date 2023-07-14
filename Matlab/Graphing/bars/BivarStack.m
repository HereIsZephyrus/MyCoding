% 柱状图（叠加）绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load BostonTemp.mat
% 自变量
x = 1:12;
% 因变量
yearIdx = 13; % 年份索引
y1 = Temperatures(yearIdx,:);
y2 = mean(Temperatures);

%% 颜色定义
% colorplus函数获取方式：
% 公众号后台回复：450
C1 = colorplus(419);
C2 = colorplus(45);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 12;
figureHeight = 12;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]); % define the new figure dimensions
hold on

%% 柱状图（叠加）绘制
b1 = bar(x,y1,0.7);
hold on
b2 = bar(x,y2,0.25);

%% 细节优化
% 赋色+边缘调整
set(b1,'FaceColor', C1, 'EdgeColor','black', 'LineWidth',1.5)
set(b2,'FaceColor', C2, 'EdgeColor','black', 'LineWidth',1)

% 坐标轴美化
set(gca, 'Box', 'off', ...                                         % 边框
         'XGrid', 'off', 'YGrid', 'off', ...                       % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...            % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...             % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...           % 坐标轴颜色
         'XTick', 1:12,...                                         % 刻度位置、间隔、范围
         'YTick', 0:10:80,...                                      
         'Xlim' , [0 13],...
         'Ylim' , [0 80], ...
         'Xticklabel', Months,...                                  % X坐标轴刻度标签
         'Yticklabel',{0:10:80})                                   % Y坐标轴刻度标签
hLegend = legend(sprintf('Average Monthly Temperatures in %d',Year(yearIdx)),...
                 'Mean Temperature (2000 - 2020)',...
                 'Location','southoutside');
hTitle = title(sprintf('Average Monthly Temperatures in %d',Year(yearIdx)));
hXLabel = xlabel('Month');
hYLabel = ylabel('Temperature (\circF)');

% 字体和字号
set(gca, 'FontName', 'Helvetica')
set([hTitle, hXLabel, hYLabel], 'FontName', 'AvantGarde')
set([hLegend, gca], 'FontSize', 10)
set([hXLabel, hYLabel], 'FontSize', 12)
set(hTitle, 'FontSize', 12, 'FontWeight' , 'bold')

% 背景颜色
set(gcf,'Color',[1 1 1])

%% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'eg3';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');