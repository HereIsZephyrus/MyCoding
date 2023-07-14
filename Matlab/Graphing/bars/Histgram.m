% 直方图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load data.mat;

%% 颜色定义
% colorplus函数获取方式：
% 公众号后台回复：450
C = colorplus([378 187 83]);
C1 = C(1,:);
C2 = C(2,:);
C3 = C(3,:);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 12;
figureHeight = 8;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

%% 直方图绘制
h1 = histogram(data1,25);
h2 = histogram(data2,25);
h3 = histogram(data3,25);
hTitle = title('Histogram Plot');
hXLabel = xlabel('XAxis');
hYLabel = ylabel('YAxis');

%% 细节优化
% 赋色
set(h1,'facecolor',C1,'facealpha',0.8)
set(h2,'facecolor',C2,'facealpha',0.8)
set(h3,'facecolor',C3,'facealpha',0.8)
% 坐标轴美化
set(gca, 'Box', 'off', ...                                       % 边框
         'XGrid', 'off', 'YGrid', 'on', ...                      % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...          % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...           % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...         % 坐标轴颜色
         'XTick', -8:2:8,...                                     % 刻度位置、间隔、范围
         'YTick', 0:100:800,...                                      
         'Xlim' , [-8 8],...
         'Ylim' , [0 700])
% 添加图例
hLegend = legend([h1,h2,h3], ...
                 'Samp1', 'Samp2','Samp3', ...
                 'Location', 'northeast');
hLegend.ItemTokenSize = [7 7];
P = hLegend.Position;
hLegend.Position = P + [0.015 0.03 0 0];
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 10)
set([hXLabel,hYLabel,hLegend], 'FontName',  'Arial', 'FontSize', 10)
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
