% Matlab进阶绘图-雷达图
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load data.mat
% 初始化参数
dataset = P;
lbs = {'Yield strength',...
       'Ultimate tensile strength',...
       'Elongation to fracture',...
       'UTS×EF',...
       'Saturation induction',...
       'Coercivity',...
       'Electrical resistivity'};
lgs = {'M-MCA','Fe-49Co-2V','Fe-78.5Ni','Fe-4Si'};

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
map = TheColor('sci',1796);
C = map(1:4,:);

% C = TheColor('sci',2068,'map',4);
% % C = flipud(C);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 20;
figureHeight = 12;

%% 窗口设置
figureHandle = figure('color','w');
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);

%% 雷达图绘制
Spider_plot(dataset,...
    'AxesLabels', lbs,...                                  % 角度坐标标签
    'AxesLabelsEdge', 'none',...                           % 角度坐标标签边框
    'AxesLabelsOffset',0.2,...                             % 角度坐标标签偏移量
    'LabelFontSize',12,...                                 % 角度坐标标签字号
    'AxesLineStyle','--',...                               % 角度坐标轴线型
    'AxesLineWidth',0.5,...                                % 角度坐标轴线宽
    'AxesDisplay', 'one',...                               % 半径坐标刻度
    'AxesLimits', [1,1,1,1,1,1,1;10,10,10,10,10,10,10],... % 半径坐标范围
    'AxesPrecision', 0,...                                 % 半径坐标刻度值精度
    'AxesFontSize',11,...                                  % 半径坐标标签字号
    'AxesInterval', 4,...                                  % 半径坐标轴线数
    'AxesHorzalign','center',...                           % 半径坐标标签水平对齐模式
    'AxesVertalign','bottom',...                           % 半径坐标标签垂直对齐模式
    'BackgroundColor','none',...                           % 背景颜色
    'Color', C,...                                         % 线颜色
    'LineWidth', 1.5,...                                   % 线宽
    'Marker', {'v', 'o', '^', 's'},...                     % 符号类型
    'MarkerSize',50,...                                    % 符号尺寸
    'FillOption', {'on', 'on', 'on', 'on'},...             % 是否填充
    'FillTransparency', 0.12);                             % 填充透明度

%% 细节优化
% Legend
hLegend = legend(lgs,...
                'FontWeight','normal',...
                'Box','off',...
                'Location', 'northeast');
% Legend位置微调 
LP = hLegend.Position;
hLegend.Position = LP + [0.15 -0.25 0 0.05];
% 字体和字号
set(hLegend, 'FontName', 'Arial', 'FontSize', 10)
th = findobj(gca, 'Type', 'text');
set(th, 'FontName', 'Arial', 'fontweight','bold')
% 背景颜色
set(gcf,'Color',[1 1 1])

%% 图片输出
exportgraphics(figureHandle,'test.png','Resolution',300)
