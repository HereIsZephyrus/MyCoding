% 二元直方图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load rideData.mat

%% 颜色定义
% addcolorplus函数获取方式：
% 公众号后台回复：配色强化
map = addcolorplus(296);
map = flipud(map);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

%% 二元直方图绘制
h1 = histogram2(rideData.Duration, rideData.birth_date,...
   'DisplayStyle','bar3',...
   'ShowEmptyBins','off',...
   'FaceColor','flat',...
   'FaceLighting','flat');  
hTitle = title('Ride counts based on ride length and the age of the rider');
hXLabel = xlabel('Length of Ride');
hYLabel = ylabel('Birth Year');
hZLabel = zlabel('Number of Rides');
view(17,30)

%% 细节优化
% 赋色
colormap(map)
% 坐标轴美化
set(gca, 'Box', 'on', ...                                                   % 边框
         'XGrid', 'on', 'YGrid', 'on', 'ZGrid', 'on', ...                   % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...                     % 刻度
         'XMinorTick','off','YMinorTick','off','ZMinorTick','off', ...      % 小刻度
         'XColor', [.1 .1 .1],'YColor', [.1 .1 .1],'ZColor', [.1 .1 .1],... % 坐标轴颜色
         'ytick',1920:20:2000,...                                           % 坐标轴刻度范围
         'ylim',[1930 1990])
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 10)
set([hXLabel,hYLabel,hZLabel], 'FontName',  'Arial', 'FontSize', 10)
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
