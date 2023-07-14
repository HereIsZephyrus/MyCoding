% 抖动控制的分簇散点图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
tbl = readtable(fullfile(matlabroot,'examples','matlab','data','BicycleCounts.csv'));
daynames = ["Sunday" "Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday"];
x = categorical(tbl.Day,daynames);
y = tbl.Total;
c = hour(tbl.Timestamp);

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
map = TheColor('sci',2068);
% map = flipud(map);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 16;
figureHeight = 10;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

%% 抖动控制的分簇散点图绘制
s = swarmchart(x,y,8,c,'filled');
hTitle = title('Distribution of bicycle traffic by the day of the week');
c = colorbar();
hYlabel1 = ylabel(c, 'Time of the day');
hYlabel2 = ylabel('Number of bicycles');

%% 细节优化
% 赋色
colormap(map)
% 调节抖动类型与抖动宽度
set(s, 'XJitter', 'rand',...
       'XJitterWidth', 0.5)
% 坐标轴美化
set(gca, 'Box', 'off', ...                                   % 边框
         'LineWidth',1,...                                   % 线宽
         'XGrid', 'off', 'YGrid', 'off', ...                 % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...      % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...       % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])        % 坐标轴颜色
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 10)
set([hYlabel1,hYlabel2], 'FontName',  'Arial', 'FontSize', 10)
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