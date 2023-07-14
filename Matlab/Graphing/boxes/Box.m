% 填充箱线图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load data.mat
% 绘制箱线图，提取箱子数据
figure
boxplot(MPG,Origin,'Colors',C,'Symbol','o');
boxobj = findobj(gca,'Tag','Box');
for i=1:length(boxobj)
    X(i,:) = get(boxobj(i),'XData');
    Y(i,:) = get(boxobj(i),'YData');
end
close

%% 颜色定义
% colorplus函数获取方式：
% 公众号后台回复：450
C = colorplus(441);
CF = colorplus([333,259,365,419]);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 12;
figureHeight = 10;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);

%% 绘制填充箱线图
for j=1:length(boxobj)
    patch(X(j,:),Y(j,:),CF(j,:),'EdgeColor',C,'FaceAlpha',1,'LineWidth',1.5);
end
hold on
h=boxplot(MPG,Origin,'Colors',C,'Symbol','o');
hTitle = title('Miles per Gallon by Vehicle Origin');
hXLabel = xlabel('Country of Origin');
hYLabel = ylabel('Miles per Gallon (MPG)');

%% 细节优化
% 线宽
set(h,'LineWidth',1.5)
% 坐标轴美化
set(gca, 'Box', 'on', ...                                        % 边框
         'LineWidth', 1,...                                      % 线宽
         'XGrid', 'off', 'YGrid', 'off', ...                     % 网格
         'TickDir', 'in', 'TickLength', [.015 .015], ...         % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...           % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])            % 坐标轴颜色
% 字体和字号
set(gca, 'FontName', 'Helvetica')
set([hXLabel, hYLabel], 'FontName', 'AvantGarde')
set(gca, 'FontSize', 10)
set([hXLabel, hYLabel], 'FontSize', 11)
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