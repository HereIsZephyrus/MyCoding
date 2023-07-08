% 分簇散点图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load data.mat

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
C = TheColor('hunt',189);
% C = TheColor('hunt',203);
% C = TheColor('hunt',603);
C1 = C(1,:);
C2 = C(2,:);
C3 = C(3,:);
C4 = C(4,:);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

%% 分簇散点图绘制
ms = 8;
s1 = swarmchart(x1,y1,ms,C1,'filled');
s2 = swarmchart(x2,y2,ms,C2,'filled');
s3 = swarmchart(x3,y3,ms,C3,'filled');
s4 = swarmchart(x4,y4,ms,C4,'filled');
hTitle = title('Swarm Plot');
hXLabel = xlabel('XAxis');
hYLabel = ylabel('YAxis');

%% 细节优化
% 调节抖动宽度
xjs = 0.6;
set(s1,'XJitterWidth',xjs)
set(s2,'XJitterWidth',xjs)
set(s3,'XJitterWidth',xjs)
set(s4,'XJitterWidth',xjs)
% 坐标轴美化
set(gca, 'Box', 'off', ...                                       % 边框
         'LineWidth',1,...
         'XGrid', 'off', 'YGrid', 'off', ...                     % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...          % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...           % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...         % 坐标轴颜色
         'XTick', 1:4,...                                    
         'YLim',[-3.5 5.5],...
         'XTickLabel',{'Samp1';'Samp2';'Samp3';'Samp4'})
% 添加上右框线
XL = get(gca,'xlim'); XR = XL(2);
YL = get(gca,'ylim'); YT = YL(2);
xc = get(gca,'XColor');
yc = get(gca,'YColor');
plot(XL,YT*ones(size(XL)),'color', xc,'linewidth',1)
plot(XR*ones(size(YL)),YL,'color', yc,'linewidth',1)
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 10)
set([hXLabel,hYLabel], 'FontName',  'Arial', 'FontSize', 10)
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
