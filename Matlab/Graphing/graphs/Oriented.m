% 有向图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load data.mat
% 初始化
S = s;
T = t;

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
C = TheColor('sci',1);
C1 = C(1,:);
C2 = C(6,:);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 14;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);

%% 有向图绘制
G = digraph(S,T);
% p = plot(G,'Layout','circle');
p = plot(G,'Layout','force');

%% 细节优化
% 线条属性调整
p.EdgeColor = C1;
p.LineStyle = '-';
p.LineWidth = 2;
% 节点属性调整
p.Marker = 's';
p.NodeColor = C2;
p.MarkerSize = 12;
% 坐标区调整
axis off
% 标签、字体和字号
labels = {'A1','B1','F1','F2','D1','D2','D3','D4','D6','M1','M2','M3','M4','M6','M7','G1'};
p.NodeLabel = labels;
p.NodeFontSize = 10;
p.NodeFontName = 'Arail';
% 背景颜色
set(gcf,'Color',[1 1 1])

%% 图片输出
exportgraphics(gca,'test0.png','Resolution',300)