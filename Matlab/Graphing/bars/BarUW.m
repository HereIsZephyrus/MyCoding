% Matlab进阶绘图-不等宽柱状图
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load data.mat
% 初始化参数
X = x;
Y = y;
LW = 1;

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
C = TheColor('sci',2052,'map',5);
C = flipud(C);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);

%% 不等宽柱状图绘制
h = uwbar(X,Y,LW,C);
hTitle = title('Bar chart with unequal width');
hXLabel = xlabel('Scale');
hYLabel = ylabel('RMSE (m)');

%% 细节优化
% 坐标区调整
set(gca, 'Box', 'off', ...                                         % 边框
         'LineWidth', 1, 'GridLineStyle', '-',...                  % 坐标轴线宽
         'XGrid', 'on', 'YGrid', 'on', ...                         % 网格
         'TickDir', 'out', 'TickLength', [.015 .015], ...          % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...             % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...           % 坐标轴颜色
         'YTick', 0:10:100,...                                     % 坐标轴刻度
         'Ylim' , [-2 60], ...                                     
         'Xlim' , [-3 93], ...
         'XTick', 0:10:100)
% Legend 
hLegend = legend(h, ...
                 'A', 'B', 'C', 'D', 'E', ...
                 'Location', 'eastoutside');
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 10)
set([hXLabel, hYLabel], 'FontSize', 11, 'FontName', 'Arial')
set(hTitle, 'FontSize', 12, 'FontWeight' , 'bold')
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
fileout = 'test';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');

function h = uwbar(x,y,lw,color)
% x     - x vector including N numbers
% y     - y vector including N numbers
% lw    - line width
% color - N*3 FaceColor Matrix
% 公众号：阿昆的科研日常

% assign default values for undeclared parameters
x = x(:);
y = y(:);
nx = length(x)-1;

% plot the bars
for i=1:nx
    
    x1=x(i); x2=x(i+1); y1=y(i);
    % set vertices
    verts=[x1 0
           x1 y1
           x2 y1
           x2 0];
    % set faces
    faces=[1 2 3 4];
    
    patchinfo.Vertices = verts;
    patchinfo.Faces = faces;
    
    patchinfo.FaceColor = color(i,1:3);
    h(i)=patch(patchinfo,'LineWidth',lw);
    hold on;
end
end
