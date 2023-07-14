% 横向堆叠图绘制模板
% 公众号：阿昆的科研日常
%% 数据准备
% 读取数据
% 自变量
X = 1:7;
% 因变量
A = [0.09 	0.11 	0.15 	0.15    0.22    0.33    0.35
     0.06 	0.11 	0.08 	0.18    0.15    0.22    0.38
     0.08 	0.05 	0.13 	0.15 	0.15    0.30    0.39
     0.07 	0.08 	0.16 	0.12 	0.28    0.28    0.39 
     0.05 	0.09 	0.08 	0.10 	0.17    0.22    0.39
     0.08 	0.10 	0.06 	0.18    0.27    0.22    0.35
];

%% 颜色定义
% addcolorplus函数获取方式：
% 公众号后台回复：配色强化

% 渐变色选择
map = addcolorplus(288);
num = size(A,1); % 变量数
idx = linspace(1,64,num); 
idx = round(idx);
C = map(idx,:);
% C = flipud(C);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 12;
figureHeight = 6;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]); % define the new figure dimensions
hold on

%% 堆叠图绘制
GO = barh(X,A',0.8,'stacked','EdgeColor','k');

%% 细节优化
% 赋色
GO(1).FaceColor = C(1,:);
GO(2).FaceColor = C(2,:);
GO(3).FaceColor = C(3,:);
GO(4).FaceColor = C(4,:);
GO(5).FaceColor = C(5,:);
GO(6).FaceColor = C(6,:);

% 坐标轴美化
set(gca, 'Box', 'off', ...                                         % 边框
         'XGrid', 'off', 'YGrid', 'off', ...                       % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...            % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...             % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...           % 坐标轴颜色
         'XTick',0:0.5:3,...                                       % 刻度位置、间隔、范围
         'YTick',1:7,...                                      
         'Xlim' ,[0 2.5],...
         'Ylim' , [0.4 7.6], ...
         'Yticklabel',{'M1' 'M2' 'M3' 'M4' 'M5'  'M6' 'M7'},...    % Y坐标轴刻度标签
         'Xticklabel',{[0:0.5:3]})                                 % X坐标轴刻度标签

% 标签及Legend 设置    
hYLabel = xlabel('RMSE (m)');
hLegend = legend([GO(1),GO(2),GO(3),GO(4),GO(5),GO(6)], ...
                 'S1', 'S2', 'S3', 'S4', 'S5', 'S6', ...
                 'Location', 'southeast','Orientation','horizontal');
hLegend.ItemTokenSize = [5 5];
legend('boxoff');

% 字体和字号
set(gca,  'FontSize', 10)

% 背景颜色
set(gca,'Color',[1 1 1])

%% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'test9';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');
