% 对数刻度柱状图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
% 自变量
x = 1:7;
% 因变量
dataset = [27687 9229 1387 1066 447 147 26];

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
% 对比色
C = TheColor('sci',999);
% 渐变色
% C = TheColor('sci',2064,'map',7);
% C = flipud(C);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 11;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);

%% 对数刻度柱状图绘制
GO = bar(x,dataset,0.8,'EdgeColor','k','LineWidth', 1);
hTitle = title('Bar chart with logarithmic scale');
hXLabel = xlabel('Layers');
hYLabel = ylabel('Number of nodes');

%% 细节优化
% 赋色
GO.FaceColor = 'flat';
for i = 1:7
    GO.CData(i,:) = C(i,:);
end
% 坐标区调整
set(gca, 'Box', 'off', ...                                         % 边框
         'LineWidth', 1, 'GridLineStyle', '-',...                  % 坐标轴线宽
         'XGrid', 'off', 'YGrid', 'on', ...                        % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...            % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...             % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...           % 坐标轴颜色
         'XScale','linear','YScale','log',...                      % 坐标轴刻度类型
         'XLim',[0.4 7.5],...                                      % X坐标范围
         'Xticklabel',{'layer0','layer1','layer2','layer3', ...    % X坐标轴刻度标签
                       'layer4','layer5','layer6'})                                 
% 添加上、右框线
hold on
XL = get(gca,'xlim'); XR = XL(2);
YL = get(gca,'ylim'); YT = YL(2);
xc = get(gca,'XColor');
yc = get(gca,'YColor');
plot(XL,YT*ones(size(XL)),'color', xc,'linewidth',1)
plot(XR*ones(size(YL)),YL,'color', yc,'linewidth',1)
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 10)
set([hXLabel, hYLabel], 'FontSize', 11, 'FontName', 'Arial')
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