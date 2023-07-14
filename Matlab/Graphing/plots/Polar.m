% 极坐标线图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load data.mat

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
C = TheColor('sci',1);
C1 = C(1,:);
C2 = C(2,:);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 14;
figureHeight = 14;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]); 

%% 极坐标线图绘制
P1 = polarplot(theta,rho1);
hold on
P2 = polarplot(theta,rho2); 
hTitle = title('Plot of Polar Coordinate Defined Function');

%% 细节优化
% 定义线宽和颜色(或线型、符号、线宽和颜色)
set(P1, 'LineWidth', 2,  'Color', C1)
set(P2, 'LineWidth', 2,  'Color', C2)
% 坐标区调整
set(gca, 'LineWidth',0.7,...                               % 线宽
         'RGrid','on','ThetaGrid','on',...                 % 网格
         'GridColor',[0 0 0],...                           % 网格颜色
         'ThetaZeroLocation','right',...                   % 极角0位置
         'TickDir', 'out', 'TickLength', [0 0], ...        % 刻度
         'RMinorTick', 'off', 'ThetaMinorTick', 'off', ... % 小刻度
         'ThetaDir', 'clockwise',...                       % 极角方向                                                        % 边框
         'RColor', [0.8 0 0],  'ThetaColor', [0 0 0],...   % 极角极径线、字颜色
         'RTick',0:0.1:0.6,...                             % 坐标轴刻度调整
         'RLim',[0 0.6],'ThetaLim',[0 360])
% Legend
hLegend = legend([P1,P2], ...
                 'Samp1', 'Samp2', ...
                 'Location', 'northeast',...
                 'orientation','vertical');
P = hLegend.Position;
hLegend.Position = P + [0.1 0.03 0 0];
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 11)
set(hLegend, 'FontName', 'Arial', 'FontSize', 11)
set(hTitle, 'FontName', 'Arial', 'FontSize', 12, 'FontWeight' , 'bold')
% 背景颜色
set(gcf,'Color',[1 1 1])

%% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'test';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');