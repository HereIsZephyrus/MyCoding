% 堆叠图绘制模板
% 公众号：阿昆的科研日常
%% 数据准备
% 读取数据
% 自变量
X = 1:5;
% 因变量
A = [0.19 	0.31 	0.25 	0.25    0.16
     0.22 	0.35 	0.38 	0.28    0.17
     0.23 	0.32 	0.33 	0.25 	0.25
     0.37 	0.37 	0.36 	0.32 	0.38 
     0.33 	0.39 	0.38 	0.30 	0.27
     0.23 	0.20 	0.36 	0.28    0.23
];

%% 颜色定义
% addcolorplus函数获取方式：
% 公众号后台回复：配色强化

% 渐变色选择
map = addcolorplus(319);
num = size(A,1); % 变量数
idx = linspace(1,64,num); 
idx = round(idx);
C = map(idx,:);

% 单一颜色选择
% C = addcolorplus([222 223 224 225 226 231]);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 8;
figureHeight = 12;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]); % define the new figure dimensions
hold on

%% 堆叠图绘制
GO = bar(X,A',0.9,'stacked','EdgeColor','k');

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
         'XGrid', 'off', 'YGrid', 'on', ...                        % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...            % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...             % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...           % 坐标轴颜色
         'XTick', 1:5,...                                          % 刻度位置、间隔、范围
         'YTick', 0:0.5:3,...                                      
         'Xlim' ,[0.4 5.6],...
         'Ylim' , [0 2.5], ...
         'Xticklabel',{'1' '2' '3' '4' '5'},...                    % X坐标轴刻度标签
         'Yticklabel',{[0:0.5:3]})                                 % Y坐标轴刻度标签

% 标签及Legend 设置    
hYLabel = ylabel('RMSE (m)');
hLegend = legend([GO(1),GO(2),GO(3),GO(4),GO(5),GO(6)], ...
                 'S1', 'S2', 'S3', 'S4', 'S5', 'S6', ...
                 'Location', 'eastoutside','Orientation','vertical');
hLegend.ItemTokenSize = [5 5];
legend('boxoff');


% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 10)

% 背景颜色
set(gca,'Color',[1 1 1])

%% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'test';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');
