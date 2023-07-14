% 平行坐标图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
tbl = readtable('TemperatureData.csv');
tbl.Year = categorical(tbl.Year);
NoDataMonths = {'September','October','November','December','August'};
NoDataMonthsIdx = ismember(tbl.Month,NoDataMonths);
tbl(NoDataMonthsIdx,:) = [];

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
% 对比色
% C = TheColor('sci',999);
% C = TheColor('sci',2037);
% 渐变色
C = TheColor('sci',2064,'map',7);
% C = TheColor('sci',1701,'map',7);
%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 20;
figureHeight = 12;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);

%% 平行坐标图绘制
p = parallelplot(tbl);                          
p.Title = 'Temperature Data';

%% 细节优化
p.GroupVariable = 'Month';
p.CoordinateVariables = [1 2 4];
p.DataNormalization = 'none';
p.Color = C;

categoricalMonth = categorical(p.SourceTable.Month);
Order = {'January','February','March','April','May','June','July'};
OrderMonth = reordercats(categoricalMonth,Order);
p.SourceTable.Month = OrderMonth;

% 背景颜色
set(gcf,'Color',[1 1 1])

%% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'test';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');
