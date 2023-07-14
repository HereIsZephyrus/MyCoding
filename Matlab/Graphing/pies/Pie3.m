% 三维饼图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
X = [0.49 0.12 0.1 0.08 0.08 0.04 0.04 0.05];
Label = {'Brazil','Colombia','Argentina','Peru','Venezuela','Chile','Ecuador','Others'};
explode=zeros(length(X),1);

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
map = TheColor('sci',2050);
map = flipud(map);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 8;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);

%% 三维饼图绘制
pie3(X,explode);
hTitle = title('South American Population by Country');

%% 细节优化
% 赋色
colormap(map)
% 标签
hLegend = legend(Label, 'Position', [0.88 0.35 0.1 0.3]);
hLegend.ItemTokenSize = [5 5];
legend('boxoff');
% 字体字号
th = findobj(gca, 'Type', 'text');
set(th, 'FontName', 'Arial', 'FontSize', 11)
set(hLegend, 'FontName',  'Arial', 'FontSize', 9)
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