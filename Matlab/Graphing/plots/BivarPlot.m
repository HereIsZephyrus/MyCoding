% 双轴折线图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
% 自变量X
X = 0:0.05:10; 
% 因变量Y1，对应左轴
Y1 = 0.5*exp(-0.5*X).*sin(10*X);
% 因变量Y2，对应右轴
Y2 = fliplr(Y1*10);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 12;
figureHeight = 8;

%% 定义线型、标记符号、线宽和颜色
% addcolor函数获取方式：
% 公众号后台回复：morecolor

% 定义因变量Y1线型、符号、线宽与颜色
Y1_LS = '-'; 
Y1_MK = 'none'; 
Y1_LW = 1.5;
Y1_C = addcolorplus(185);

% 定义因变量Y2线型、符号、线宽与颜色
Y2_LS = '-'; 
Y2_MK = 'none'; 
Y2_LW = 1.5;
Y2_C = addcolorplus(1);

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [10 10 figureWidth figureHeight]);
hold on

%% 定义左轴
yyaxis left
A1 = line(X,Y1);
set(A1, 'LineStyle',Y1_LS,'Marker',Y1_MK,'LineWidth', Y1_LW,  'Color', Y1_C)
hYLabel1 = ylabel('Acurracy (%)');
% 坐标区调整
set(gca, 'YColor', [.1 .1 .1],...           % 坐标轴颜色
         'YTick', -0.6:0.2:0.6,...          % 刻度位置、间隔
         'Ylim' , [-0.6 0.6], ...           % 坐标轴范围
         'Yticklabel',{[-0.6:0.2:0.6]})     % Y坐标轴刻度标签
     
%% 定义右轴
yyaxis right
A2 = line(X,Y2);
set(A2, 'LineStyle',Y2_LS,'Marker',Y2_MK,'LineWidth', Y2_LW,  'Color', Y2_C)
hYLabel2 = ylabel('Time (s)');
% 坐标区调整
set(gca, 'YColor', [.1 .1 .1],...           % 坐标轴颜色
         'YTick',  -6:2:6,...               % 刻度位置、间隔
         'Ylim' ,  [-6 6], ...              % 坐标轴范围
         'Yticklabel',{[-6:2:6]})           % Y坐标轴刻度标签
     
%% X轴与其它细节调整
hXLabel = xlabel('X');
set(gca, 'Box', 'off', ...                                         % 边框
         'XGrid', 'off', 'YGrid', 'on', ...                        % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...            % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...             % 小刻度
         'XColor', [.1 .1 .1],...                                  % 坐标轴颜色
         'XTick', 0:2:10,...                                       % 刻度位置、间隔
         'Xlim' , [0 10], ...                                      % 坐标轴范围
         'Xticklabel',{[0:2:10]})                                  % X坐标轴刻度标签
     

% 标签及Legend 设置  
hLegend = legend([A1,A2], ...
    'Y1', 'Y2', ...
    'Location', 'northeast','orientation','horizontal');

% Legend位置微调 
P = hLegend.Position;
hLegend.Position = P + [0.01 0.03 0 0];

% 刻度标签字体和字号
set(gca, 'FontName', 'Helvetica', 'FontSize', 10)

% 背景颜色
set(gcf,'Color',[1 1 1])

%% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'eg1';
print(figureHandle,[fileout,'.png'],'-r600','-dpng');
