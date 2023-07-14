% 横向多组堆叠图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
% 自变量
Y = 1:18;
Y(3:3:18) = [];
% 因变量
X = [5.5 5.6 8.5 8.7 7.1 7.2
     5.5 5.6 8.5 8.8 7.1 7.3
     3.3 3.1 5.2 4.2 4.1 4.1
     2.6 2.2 5.1 4.1 4.5 4.4];
X = repmat(X,1,2);

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
num = size(X,1); % 堆叠柱数
C = TheColor('sci',2068,'map',num*2);
C1 = C(1:4,:); % 第一组颜色
C2 = C(5:8,:); % 第二组颜色

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 18;
figureHeight = 9;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

%% 多组堆叠图绘制
% 第一组
X1 = zeros(size(X));
X1(:,1:2:12) = X(:,1:2:12);
GO1 = barh(Y,X1',1,'stacked','EdgeColor','k');
hold on
% 第二组
X2 = zeros(size(X));
X2(:,2:2:12) = X(:,2:2:12);
GO2 = barh(Y,X2',1,'stacked','EdgeColor','k');
hTitle = title('HMultiStackBar Plot');
hXLabel = xlabel('Point spacing');
hYLabel = ylabel('Samples');

%% 细节优化
% 赋色
% 第一组的赋色
GO1(1).FaceColor = C1(1,:);
GO1(2).FaceColor = C1(2,:);
GO1(3).FaceColor = C1(3,:);
GO1(4).FaceColor = C1(4,:);
% 第二组的赋色
GO2(1).FaceColor = C2(1,:);
GO2(2).FaceColor = C2(2,:);
GO2(3).FaceColor = C2(3,:);
GO2(4).FaceColor = C2(4,:);
% 坐标轴美化
set(gca, 'Box', 'off', ...                                         % 边框
         'XGrid', 'off', 'YGrid', 'off', ...                       % 网格
         'TickDir', 'out', 'TickLength', [.005 .005], ...          % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...             % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...           % 坐标轴颜色
         'YTick',Y(1:2:end)+0.5,...
         'YTickLabel',{'s1','s2','s3','s4','s5','s6'})
% Legend设置    
hLegend = legend([GO1(1),GO1(2),GO1(3),GO1(4),GO2(1),GO2(2),GO2(3),GO2(4)], ...
                 'A1', 'A2', 'A3', 'A4','B1', 'B2', 'B3', 'B4', ...
                 'Location', 'eastoutside','Orientation','vertical');
hLegend.ItemTokenSize = [5 5];
legend('boxoff');
% 字体和字号
set(gca, 'FontName', 'Helvetica')
set([hXLabel, hYLabel, hLegend], 'FontName', 'AvantGarde')
set(gca, 'FontSize', 10)
set([hXLabel, hYLabel, hLegend], 'FontSize', 11)
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
