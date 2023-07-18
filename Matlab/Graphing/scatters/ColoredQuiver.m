% 模值赋色的箭头图绘制模板
% By：阿昆的科研日常

%% 数据准备
% 读取数据
load data.mat

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
map = TheColor('sci',2068);
% map = flipud(map);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 16;
figureHeight = 14;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);

%% 模值赋色的箭头图绘制
q = quiver(X,Y,U,V);
hTitle = title('Visualization of air flow data over North America');
hXLabel = xlabel('xaxis');
hYLabel = ylabel('yaxis');

%% 细节优化
% 赋色
ColortheArrow(q,map)
colorbar
% 线型调整
q.LineWidth = 1;
q.ShowArrowHead  = 'on';
% 坐标区调整
axis tight
set(gca, 'Box', 'off', ...                                   % 边框
         'LineWidth', 1,...                                  % 线宽
         'XGrid', 'off', 'YGrid', 'off', ...                 % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...      % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...       % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])        % 坐标轴颜色
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 10)
set([hXLabel, hYLabel], 'FontSize', 11, 'FontName', 'Arial')
set(hTitle, 'FontSize', 12, 'FontWeight' , 'bold')
% 背景颜色
set(gcf,'Color',[1 1 1])
% 添加上、右框线
hold on
XL = get(gca,'xlim'); XR = XL(2);
YL = get(gca,'ylim'); YT = YL(2);
xc = get(gca,'XColor');
yc = get(gca,'YColor');
plot(XL,YT*ones(size(XL)),'color', xc,'linewidth',1)
plot(XR*ones(size(YL)),YL,'color', yc,'linewidth',1)

%% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'test';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');