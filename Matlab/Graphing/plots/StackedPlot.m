% 堆叠折线图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
tbl = readtable('patients.xls');

%% 颜色定义
% addcolorplus函数获取方式：
% 公众号后台回复：配色强化
idx = linspace(1,64,4); 
idx = round(idx);
map = addcolorplus(300);
C = map(idx,:);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 16;
figureHeight = 9;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);

%% 堆叠折线图绘制
s = stackedplot(tbl,{'Height','Weight','Systolic','Diastolic'},'LineWidth',2);

%% 细节优化
% 赋色
s.LineProperties(1).Color = C(1,:);   
s.LineProperties(2).Color = C(2,:);   
s.LineProperties(3).Color = C(3,:);   
s.LineProperties(4).Color = C(4,:);   
% 字体和字号
set(gca, 'FontName', 'Helvetica', 'FontSize', 10)
% 背景颜色
set(gcf,'Color',[1 1 1])

%% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'test';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');