% 词云图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
load sonnetsTable

%% 颜色定义
% addcolorplus函数获取方式：
% 公众号后台回复：配色强化
map = addcolorplus(300);
map = flipud(map);
idx = linspace(1,64,10); 
idx = round(idx);
C = map(idx,:);
numWords = height(tbl);
r = randi([1,size(C,1)],numWords,1);
colors = C(r,1:3);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%% 窗口设置
figureHandle = figure('color','w');
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]); 

%% 词云图绘制
wc = wordcloud(tbl,'Word','Count',...
                   'Color',colors,...
                   'FontName','Arial');
title('');

%% 图片输出
print('test0.png','-r300','-dpng');