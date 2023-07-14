% Matlab进阶绘图-三维堆叠柱状图
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load data.mat
% 初始化
dataset = X;
s = 0.4; % 柱子宽度
n = size(dataset,3); % 堆叠组数

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC

% SCI配色库
% map = TheColor('sci',1686,'map',n);
% % map = flipud(map);

% 图片取色
% map = TheColor('copy');
% close

% Dream配色库
map = TheColor('dream',1);
% map = flipud(map);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 18;
figureHeight = 16;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);

%% 三维堆叠柱状图绘制
h = bar3stack(dataset,s,map);
hTitle = title('Bar3Stack Plot');
hXLabel = xlabel('Variable1');
hYLabel = ylabel('Variable2');
hZLabel = zlabel('Variable3');
view(134,25)
% alpha(0.9) % 透明度

%% 细节优化
% 坐标区调整
set(gca, 'Box', 'on', ...                                                           % 边框
         'LineWidth', 1, 'GridLineStyle', '-',...                                   % 坐标轴线宽
         'XGrid', 'on', 'YGrid', 'on','ZGrid', 'on', ...                            % 网格
         'TickDir', 'out', 'TickLength', [.015 .015], ...                           % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off',  'ZMinorTick', 'off',...         % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1], 'ZColor', [.1 .1 .1],...      % 坐标轴颜色
         'xtick',1:10,...                                                           % 坐标轴刻度
         'xticklabels',1:10,...
         'ytick',1:10,...
         'ylim',[0.5 10.5],...
         'yticklabels',1:10,...
         'ztick',0:10:60,...
         'zticklabels',0:10:60,...
         'zlim',[0 60])
% Legend设置    
hLegend = legend(h,...
                 'Samp1','Samp2','Samp3','Samp4','Samp5', ...
                 'Location', 'northwest',...
                 'Orientation','vertical');
% hLegend.ItemTokenSize = [5 5];
% Legend位置微调 
P = hLegend.Position;
hLegend.Position = P + [0.05 -0.2 0 0];
% 字体和字号
set(gca, 'FontName', 'Arail', 'FontSize', 10)
set([hLegend,hXLabel, hYLabel,hZLabel], 'FontName', 'Arail', 'FontSize', 10)
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


function h = bar3stack(z,s,c)
% 公众号：阿昆的科研日常
% z   - m*n*l matrix
% s   - width of the bars (0 to 1)
% c   - l*3 color scheme matrix

x = 1:size(z,2);
y = 1:size(z,1);
ngroups = size(z,3);

% get bin centers
[x1,y1] = meshgrid(x,y);
% initial zldata
z1 = zeros(size(z,1),size(z,2));

for i = 1:ngroups
    z2 = z1;
    z1 = z1+squeeze(z(:,:,i));
    h(i) = bar3level(x1, y1, z2, z1, c(i,1:3), s);
    hold on
end
% axis tight
set(gca,'ydir','reverse')
set(gca,'xlim',[1-s/2 max(x)+s/2])
dx = diff(get(gca,'xlim'));
dy = size(z,1)+1;
dz = (sqrt(5)-1)/2*dy;
set(gca,'PlotBoxAspectRatio',[dx dy dz])
view(gca, 3);
grid on
box on
end

function h = bar3level(x,y,zl,zu,color,scale)

% assign default values for undeclared parameters
width = 1*scale;
x = x(:);
y = y(:);
zl = zl(:);
zu = zu(:);
nx = length(x);

sx = width/2;
sy = width/2;

% plot the bars
for i=1:nx
    
    x1=x(i); y1=y(i); zl1=zl(i); zu1=zu(i);
    % set vertices
    verts=[x1-sx y1-sy zl1
           x1-sx y1+sy zl1
           x1+sx y1-sy zl1
           x1+sx y1+sy zl1
           x1-sx y1-sy zu1
           x1-sx y1+sy zu1
           x1+sx y1-sy zu1
           x1+sx y1+sy zu1];
    % set faces
    faces=[1 2 6 5;
           3 1 5 7;
           4 3 7 8;
           2 4 8 6;
           5 6 8 7;
           1 2 4 3];
    
    patchinfo.Vertices = verts;
    patchinfo.Faces = faces;
    
    patchinfo.FaceColor = color;
    h=patch(patchinfo,'CDataMapping','scaled','Edgecolor','k');
    hold on;
end
end
