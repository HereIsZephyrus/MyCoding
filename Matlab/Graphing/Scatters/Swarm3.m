% 三维散点图（特征渲染赋色）绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
x=[];
y=[];
z=[];
f=[];%用于着色的特征向量
%% 颜色定义
% addcolorplus函数获取方式：
% 公众号后台回复：配色强化
map = addcolorplus(300);

%% 三维散点图（特征渲染赋色）绘制
figure
scatter3(x, y, z, 5, f, 'Marker', '.')
hTitle = title('Scatter3Feature');
hXLabel = xlabel('XAxis');
hYLabel = ylabel('YAxis');
hZLabel = zlabel('ZAxis');

%% 细节优化
% 赋色
colormap(map)
% 坐标区调整
axis equal
set(gca, 'Box', 'on', ...                                       % 边框
         'XGrid', 'on', 'YGrid', 'on', ...                      % 网格
         'TickDir', 'out', 'TickLength', [0.01 0.01], ...       % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...          % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])           % 坐标轴颜色
view(40.19,23.28);
colorbar(gca,'Position',[0.13 0.24 0.04 0.18],...
             'AxisLocation','in',...
             'TickLength',0.08);
% 字体和字号
set(gca, 'FontName', 'Helvetica')
set([hXLabel, hYLabel, hZLabel], 'FontName', 'AvantGarde')
set(gca, 'FontSize', 10)
set([hXLabel, hYLabel, hZLabel], 'FontSize', 11)
set(hTitle, 'FontSize', 11, 'FontWeight' , 'bold')
colorbar(gca,'Position',[0.13 0.24 0.04 0.18],...
             'AxisLocation','in',...
             'TickLength',0.08);
% 背景颜色
set(gcf,'Color',[1 1 1])

%% 图片输出
print('test.png','-r300','-dpng')