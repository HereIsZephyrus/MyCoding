% 柱状图(带误差棒)绘制模板
% By：阿昆的科研日常

%% 数据准备
% 读取数据
% 自变量
x = 1:5;
% 因变量
% dataset为5*3的矩阵，一行3个为一组，共5组
dataset = [0.241,0.393,0.294;
           0.219,0.254,0.238;
           0.238,0.262,0.272;
           0.198,0.329,0.287;
           0.201,0.197,0.185];
% 误差矩阵
AVG = dataset/5; % 下方长度
STD = dataset/7; % 上方长度
       
%% 颜色定义
% colorplus函数获取方式：
% 公众号后台回复：450
C1 = colorplus(66);
C2 = colorplus(374);
C3 = colorplus(357);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 12;
figureHeight = 9;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]); % define the new figure dimensions
hold on

%% 带误差棒的柱状图绘制
% 绘制初始柱状图
GO = bar(x,dataset,1,'EdgeColor','k');
% 添加误差棒
[M,N] = size(dataset);
xpos = zeros(M,N);
for i = 1:N
    xpos(:,i) = GO(1,i).XEndPoints'; % v2019b
end
hE = errorbar(xpos, dataset, AVG, STD);
% 标题
hTitle = title('Bar with errorbar');
hXLabel = xlabel('Samples');
hYLabel = ylabel('RMSE (m)');

%% 细节优化
% 柱状图赋色
GO(1).FaceColor = C1;
GO(2).FaceColor = C2;
GO(3).FaceColor = C3;
% 误差棒属性
set(hE, 'LineStyle', 'none', 'Color', 'k', 'LineWidth', 1.2)
% 坐标区调整
set(gca, 'Box', 'off', ...                                         % 边框
         'XGrid', 'off', 'YGrid', 'on', ...                        % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...            % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...             % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...           % 坐标轴颜色
         'YTick', 0:0.1:1,...                                      % 刻度位置、间隔
         'Ylim' , [0 0.5], ...                                     % 坐标轴范围
         'Xticklabel',{'samp1' 'samp2' 'samp3' 'samp4' 'samp5'},...% X坐标轴刻度标签
         'Yticklabel',{[0:0.1:1]})                                 % Y坐标轴刻度标签

% Legend 设置
hLegend = legend([GO(1),GO(2),GO(3)], ...
                 'A', 'B', 'C', ...
                 'Location', 'northeast');
% Legend位置微调
P = hLegend.Position;
hLegend.Position = P + [0.015 0.03 0 0];

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
