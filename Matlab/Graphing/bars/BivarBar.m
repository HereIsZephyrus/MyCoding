% 双柱状图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
% 自变量
X = 1:5;
% 因变量
A = [98.2 88.3 96.8 94.1 93.3
     12.4 8.9 11.5 9.8 9.6];
bar1 = [A(1,:)',zeros(5,1)];
bar2 = [zeros(5,1),A(2,:)'];

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 12;
figureHeight = 8;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]); % define the new figure dimensions
hold on

%% 颜色定义
% addcolor函数获取方式：
% 公众号后台回复：morecolor
C1 = addcolorplus(1);
C2 = addcolorplus(90);

%% 定义左轴
yyaxis left
GO1 = bar(X,bar1,1,'EdgeColor','k','FaceColor',C1);
hYLabel1 = ylabel('Acurracy (%)');
set(gca,  'YColor', [.1 .1 .1],...         % 坐标轴颜色
          'YTick', 0:10:100,...        % 刻度位置、间隔
          'Ylim' ,[80 100],...            % 坐标轴范围
          'Yticklabel',{[0:10:100]})   % Y坐标轴刻度标签

%% 定义右轴折线图
yyaxis right
GO2 = bar(X,bar2,1,'EdgeColor','k','FaceColor',C2);
hYLabel2 = ylabel('Time (s)');
set(gca, 'YColor', [.1 .1 .1],... 
         'YTick', 0:5:15, ...
         'Ylim' ,[5 15], ...
         'Yticklabel',{[0:5:15]})

     
%% X轴与其它细节调整
set(gca, 'Box', 'off', ...                                         % 边框
         'XGrid', 'off', 'YGrid', 'on', ...                        % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...            % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...             % 小刻度
         'XColor', [.1 .1 .1],...                                  % 坐标轴颜色
          'Xticklabel',{'samp1' 'samp2' 'samp3' 'samp4' 'samp5'})  % X轴标签

     
hLegend = legend([GO1(1),GO2(2)], ...
    'Acurracy', 'Time', ...
    'Location', 'northeast','orientation','horizontal');

% Legend位置微调 
P = hLegend.Position;
hLegend.Position = P + [0.01 0.02 0 0];

% 刻度标签字体和字号
set(gca, 'FontName', 'Helvetica', 'FontSize', 10)

figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'test';
print(figureHandle,[fileout,'.png'],'-r600','-dpng');