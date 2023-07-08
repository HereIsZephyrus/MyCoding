% 三维折线图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
X=[];
Y=[];
Z=[];

%% 颜色定义
% addcolorplus函数获取方式：
% 公众号后台回复：配色强化
% 渐变色
map = addcolorplus(300);
idx = linspace(1,64,22);
idx = round(idx);
C = map(idx,:);

% 对比色
% idx = 212;
% C = addcolorplus(idx:idx+21);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 11;
figureHeight = 9;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]); % define the new figure dimensions
hold on

%% 绘制三维折线图
plot3(X,Y,Z,'linewidth',1.5);
hTitle = title('Extracted Spectra Subset');
hXLabel = xlabel('Mass/Charge (M/Z)');
hYLabel = ylabel('Time');
hZLabel = zlabel('Ion Spectra');
view(26,42)

%% 细节优化
% 赋色
set(gca,'ColorOrder',C)
% 坐标区调整
set(gca, 'Box', 'on', ...                                          % 边框
         'XGrid', 'on', 'YGrid', 'on', 'ZGrid', 'on',...           % 网格
         'TickDir', 'out', 'TickLength', [.015 .015],...           % 刻度
         'xlim', [500 900],...                                     % 坐标轴范围
         'ylim', [0 22],...
         'zlim', [0 4e8])
% 字体字号
set(gca, 'FontName', 'Arial', 'FontSize', 10)
set([hXLabel,hYLabel,hZLabel], 'FontName',  'Arial', 'FontSize', 10)
set(hTitle, 'FontSize', 11, 'FontWeight' , 'bold')
% 背景颜色
set(gcf,'Color',[1 1 1])

%% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'test';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');