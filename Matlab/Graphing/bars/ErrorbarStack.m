% 带误差棒的堆叠图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load data.mat
% 初始化绘图参数
x = X;
y = A;
errD = errdw;
errU = errup;

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
map = TheColor('sci',2064,'map',10);
map = flipud(map);
C1 = map(1,1:3);
C2 = map(2,1:3);
C3 = map(3,1:3);
C4 = map(6,1:3);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 11;

%% 窗口设置
figureHandle = figure('color','w');
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

%% 带误差棒的堆叠图绘制
GO = bar(x,y',0.8,'stacked','EdgeColor','k');
% 添加误差棒
for i = 1:4
    xpos = GO(1,i).XEndPoints; % v2019b
    ypos = GO(1,i).YEndPoints; % v2019b
    errorbar(xpos, ypos, errU(i,:), errD(i,:),...
        'LineStyle','none','Color','k','LineWidth',0.8);
end
hTitle = title('Stacked bar chart with errorbar');
hXLabel = xlabel('Samples');
hYLabel = ylabel('RMSE (m)');

%% 细节优化
% 赋色
GO(1).FaceColor = C1;
GO(2).FaceColor = C2;
GO(3).FaceColor = C3;
GO(4).FaceColor = C4;
% 坐标区基本属性调整
set(gca, 'Box', 'off', ...                                         % 边框
         'LineWidth', 1, ...                                       % 线宽
         'XGrid', 'off', 'YGrid', 'on', ...                        % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...            % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...             % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])              % 坐标轴颜色
% 坐标轴刻度调整
set(gca, 'YTick', 0:0.3:1.5,...
         'Ylim' , [0 1.5], ...
         'XTick', 1:13,...
         'Xticklabel',{1:13},...
         'Yticklabel',{0:0.3:1.5})
% legend
hLegend = legend([GO(1),GO(2),GO(3),GO(4)], ...
                 'S1', 'S2','S3','S4', ...
                 'Location', 'northeast');
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 10)
set([hXLabel, hYLabel], 'FontName', 'Arial', 'FontSize', 11)
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