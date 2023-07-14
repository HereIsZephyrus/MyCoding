% 羽状图绘制模板
% By：阿昆的科研日常

%% 数据准备
% 读取数据
load data.mat
U = u;
V = v;
N = length(U);

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
C = TheColor('sci',2068,'map',N);
% C = flipud(C);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]); % define the new figure dimensions
hold on

%% 羽状图绘制
f1 = feather(U,V);
hTitle = title('Feather plot of increasing theta values');
hXLabel = xlabel('XAxis');
hYLabel = ylabel('YAxis');

%% 细节优化
% 线型调整
LineWidth = 2;
for i = 1:N
    f1(i).LineWidth = LineWidth;
    f1(i).Color = C(i,:);
end
f1(20).LineWidth = 1.5;
f1(20).Color = [0.7 0.7 0.7];
% 坐标区调整
set(gca, 'Box', 'off', ...                                   % 边框
         'Layer','bottom',...                                % 图层
         'LineWidth', 1,...                                  % 线宽
         'XGrid', 'off', 'YGrid', 'on', ...                  % 网格
         'TickDir', 'out', 'TickLength', [.005 .005], ...    % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...       % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])        % 坐标轴颜色
% 添加上、右框线
xc = get(gca,'XColor');
yc = get(gca,'YColor');
unit = get(gca,'units');
ax = axes( 'Units', unit,...
           'Position',get(gca,'Position'),...
           'XAxisLocation','top',...
           'YAxisLocation','right',...
           'Color','none',...
           'XColor',xc,...
           'YColor',yc);
set(ax, 'linewidth',1,...
        'XTick', [],...
        'YTick', []);
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