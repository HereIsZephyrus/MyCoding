% y对数刻度折线图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load responseData.mat
% 自变量
X = magnitude;
% 因变量
Y = frequency;

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
C = TheColor('sci',1796);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);

%% y对数刻度折线图绘制
semilogy(X,Y,'LineWidth',2)
hTitle = title('Magnitude Response (dB)');
hXLabel = xlabel('Magnitude (dB)');
hYLabel = ylabel('Frequency (kHz)');

%% 细节优化
% 赋色
colororder(C)
% 坐标区调整
set(gca, 'Box', 'off', ...                                % 边框
         'LineWidth',1,...                                % 线宽
         'XGrid', 'on', 'YGrid', 'on', ...                % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...   % 刻度
         'XMinorTick', 'on', 'YMinorTick', 'on', ...      % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...  % 坐标轴颜色
         'Xlim' ,[-6.5 6.5],...                           % 坐标轴范围
         'Ylim' ,[min(frequency) max(frequency)])
% 字体和字号
set(gca,'FontName','Arial','FontSize',11)
set([hXLabel,hYLabel],'FontName','Arial','FontSize',11)
set(hTitle,'FontName','Arial','FontSize',12)
% 背景颜色
set(gcf,'Color',[1 1 1])
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

%% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'test2';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');