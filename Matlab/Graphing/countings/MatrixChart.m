% 散点矩阵图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
X = randn(50,3); 

%% 颜色定义
% TheColor配色工具获取方式：
% 公众号后台回复：TC
C = TheColor('sci',813);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);

%% 散点矩阵图绘制
% S - 散点图的图形线条对象
% AX - 每个子坐标区的坐标区对象
% BigAx - 容纳子坐标区的主坐标区的坐标区对象
% H - 直方图的直方图对象
% HAx - 不可见的直方图坐标区的坐标区对象
[S,AX,BigAx,H,HAx] = plotmatrix(X);    
hTitle = title('A Comparison of Data Sets');

%% 细节优化
% 赋色
for i = 1:3
    for j = 1:3
        if i == j
            H(1,i).FaceColor = C(3*(i-1)+j,:);
            H(1,i).FaceAlpha = 0.8;
        else
            S(j,i).Color = C(3*(i-1)+j,:);
            S(j,i).MarkerSize = 18;
        end
    end
end
% 坐标轴调整
set(AX, 'linewidth',1, ...
        'FontName', 'Arial', ...
        'FontSize', 10)
set(HAx,'linewidth',1, ...
        'FontName', 'Arial', ...
        'FontSize', 10)
set(hTitle, 'FontSize', 12, 'FontWeight' , 'bold')
% 背景颜色
set(gcf,'Color',[1 1 1])

%% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'test2';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');
