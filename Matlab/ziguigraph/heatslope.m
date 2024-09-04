%% prepare
clc;clear;close all;
slopeRange = {'<=10','10-15','15-20','20-25','>25'};
coverName = {'不透水面','水体','农地','林地'};
periodName = {'2015-2017土地利用类型转移矩阵','2017-2019土地利用类型转移矩阵'};

cold = addcolorplus(272);
cold = cold(20:1:50ZoomPlot.m,:);
hot = addcolorplus(274);
hot = hot(10:2:48,:);
map = [flipud(cold);hot];

figureHandle = figure;

data1 = [0	78	0	0
-190	0	2	593
-57	0	0	198899
-4068	-151	-553104	0
    ];
data = [0	124	0	0
-113	0	9	1492
-72	1	0	198899
-3089	-43	-312022	0];
textlegend = cell(4,4);
bias = zeros(4,4);
for i = 1 : 4
    for j = 1 : 4
        textlegend{i,j} = num2str(abs(data(i,j)));
        bias(i,j) = length(textlegend{i,j})/20;
    end
end
pointSize = normalize(abs(sqrt(data(:))),'range')*0.9 + 0.1;

x = 1:size(data,2);
y = 1:size(data,1);
[X,Y] = meshgrid(x,y);
w = x(2)-x(1);
Xt = (x(1)-w/2):w:(x(end)+w/2);
Yt = (y(1)-y/2):w:(y(end)+y/2);
[Xmesh,Ymesh] = meshgrid(Xt,Yt);
Zmesh = zeros(size(Xmesh));
mesh(Xmesh,Ymesh,Zmesh,'EdgeColor','k','LineWidth',1);
view(0,90)
hold on
scatter(X(:),Y(:),pointSize*2000,data(:),'s','filled');
text(X(:)-bias(:),Y(:)-0.3,textlegend(:),fontsize=14);
hold off
axis equal tight
set(gca, 'Box', 'off', ...                                % 边框
         'Layer','bottom',...                             % 图层
         'LineWidth',1,...                                % 线宽
         'XGrid', 'off', 'YGrid', 'off', ...              % 网格
         'TickDir', 'out', 'TickLength', [0 0], ...       % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...    % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...  % 坐标轴颜色
         'xtick',1:4,...                                 % 坐标轴刻度
         'xticklabels',coverName,...
         'ytick',1:4,...
         'yticklabels',coverName)

ylabel('转移后',FontSize=14);
xlabel('转移前',FontSize=14);
title(periodName{2},FontSize=18);
colormap(map);
colorbar
