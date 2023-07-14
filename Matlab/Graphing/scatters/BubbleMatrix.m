% 气泡矩阵图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load data.mat
% 生成矩阵坐标数据
[r,c] = size(data);
x = 1:c;
y = 1:r;
[xx,yy] = meshgrid(x,y);
yy = flipud(yy);

%% 颜色定义
% addcolorplus函数获取方式：
% 公众号后台回复：配色强化
map = addcolorplus(300);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 20;
figureHeight = 15;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

%% 气泡矩阵图绘制
bubblechart(xx(:),yy(:),data(:)*10,data(:),'MarkerFaceAlpha',1);
hTitle = title('BubbleMatrix Plot');
hXLabel = xlabel('XAxis');
hYLabel = ylabel('YAxis');

%% 细节优化
% 赋色
colormap(map)
% 调节气泡大小
bubblesize([10 30])
% 坐标轴美化
axis equal
set(gca, 'Box', 'on', ...                            
         'XGrid', 'on', 'YGrid', 'on', ...                  
         'TickDir', 'in', 'TickLength', [0 0], ...         
         'XMinorTick', 'off', 'YMinorTick', 'off', ...          
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...        
         'XTick', 0:1:c+1,...                                    
         'XLim', [0 c+1],...
         'YTick', 0:1:r+1,...
         'YLim', [0 r+1],...
         'XTickLabel',{'','A1','A2','A3','A4','A5','A6','A7','A8','A9','A10',''},...
         'YTickLabel',{'','B1','B2','B3','B4','B5','B6','B7','B8','B9','B10',''})
ytickangle(90)
% 添加图例
blgd = bubblelegend('Style','vertical',...
    'BubbleSizeOrder','descending',...
    'box','off',...
    'Location','northeastoutside',...
    'NumBubbles',3,... ...
    'FontName', 'Helvetica',...
    'FontSize', 10);
colorbar('Position',[0.79,0.11,0.03,0.5])
% 字体字号
set(gca, 'FontName', 'Arial', 'FontSize', 10)
set([hXLabel,hYLabel], 'FontName',  'Arial', 'FontSize', 11)
set(hTitle, 'FontSize', 13, 'FontWeight' , 'bold')
% 背景颜色
set(gcf,'Color',[1 1 1])

%% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'test';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');
