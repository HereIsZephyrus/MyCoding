% Matlab进阶绘图-华夫图
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
A = readcell('dataset.xlsx');
data = A(2:8,2:6);

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
% C = TheColor('copy');
% close

C = TheColor('sci',503);
C = C(1:9,1:3);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 13;
figureHeight = 15;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);

%% 华夫图绘制
[h_surf,u1,u2,u3] = waffle(data,2);
hXLabel = xlabel('Clinical');
hYLabel = ylabel('Patient');

%% 细节优化
% u1标签排序
idx = [2 1 3 5 4 6 7 8 9];
% u1标签默认顺序
% idx = 1:length(u1);
% 赋色
map = C(idx,1:3);
colormap(map)
% 坐标轴美化
axis tight equal
set(gca, 'xaxislocation','bottom',...
         'yaxislocation','left',...
         'YDir','reverse',...
         'xtick',1:5,...
         'ytick',1:7,...
         'Xticklabel',{'Grade Group' 'PSA' 'ICC' 'IDC' 'Stage'},...
         'Yticklabel',{'ICC1' 'ICC2' 'ICC3' 'ICC4' 'ICC5' 'ICC6' 'ICC7'})
% Legend
hLegend = legend(h_surf(u2(idx)),u1(idx),...
                'FontWeight','normal',...
                'FontSize',9,...
                'Box','off',...
                'Location', 'eastoutside',...
                'Orientation','vertical');
hLegend.ItemTokenSize = [10 10];
% 字体和字号
set(gca, 'FontSize', 9, 'FontName', 'Arail')
set([hXLabel, hYLabel], 'FontSize', 11, 'FontName', 'Arail')
% 背景颜色
set(gcf,'Color',[1 1 1])
% 删除白边
set(gca,'LooseInset',get(gca,'TightInset'))

%% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'test0';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');

function [h_surf,u1,u2,u3] = waffle(data,lw)
% data - m*n matrix
% lw   - line width of the grid

[u1,u2,u3] = unique(data,'stable');
A = reshape(u3,size(data));
x = 1:size(data,2);
y = 1:size(data,1);
[xx,yy] = meshgrid(x,y);
data1 = [xx(:),yy(:),A(:)];
h_surf = gridplot2(data1,lw);

end

function h_surf = gridplot2(h, lw)


gd = h;
h = gca;

% Sort the input data
gd = sortrows(gd, 1);

% Assign the corresponding x, y, and z values
x = gd(:, 1);
y = gd(:, 2);
z = gd(:, 3);

% Find the increment in x and y directions
if x(1) == x(2)
    ny = diff(find(y == y(1), 2));
    nx = numel(x) / ny;
elseif y(1) == y(2)
    nx = diff(find(x == x(1), 2));
    ny = numel(y) / nx;
end

dx = (x(end) - x(1)) / (nx - 1);
dy = (y(end) - y(1)) / (ny - 1);

% Make coordinates of the verices of the patches
x_vert = [x - dx / 2, x + dx / 2, x + dx / 2, x - dx / 2];
y_vert = [y - dy / 2, y - dy / 2, y + dy / 2, y + dy / 2];

% Plot the patches
for i = 1:size(x_vert,1)
    h_surf(i) = patch(x_vert(i,:), y_vert(i,:), z(i),...
                      'edgecolor','w',...
                      'linewidth',lw,...
                      'Parent', h);
end
end
