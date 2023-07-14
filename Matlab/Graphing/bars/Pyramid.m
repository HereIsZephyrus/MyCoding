% 金字塔图绘制模板
% 公众号：阿昆的科研日常

%% 数据准备
% 读取数据
% 因变量
x = 1:4;
% 自变量
y1 = [40 55 60 70];
y2 = [-75 -75 -90 -90];

%% 颜色定义
% TheColor函数获取方式：
% 公众号后台回复：TC
C = TheColor('copy');
close
C1 = C(1,:);
C2 = C(2,:);

%% 图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 12;
figureHeight = 8;

%% 窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]); % define the new figure dimensions
hold on

%% 金字塔图绘制
B1 = barh(x,y1,0.7,'BaseValue',0);
B2 = barh(x,y2,0.7,'BaseValue',0);
hTitle = title('CASE ≤2 or improvement ≥5');

%% 细节优化
% 赋色
B1.FaceColor = C1;
B2.FaceColor = C2;
% 添加注释文本
text(-130,4,'4th visit','FontWeight','bold')
text(-130,3,'3rd visit','FontWeight','bold')
text(-130,2,'2nd visit','FontWeight','bold')
text(-130,1,'1st visit','FontWeight','bold')
text(80,4,'p=0.303')
text(80,3,'p=0.011','FontWeight','bold')
text(80,2,'p=0.170')
text(80,1,'p=0.010','FontWeight','bold')
% 坐标轴调整
set(gca,'Box','off',...
        'Layer','top',...
        'TickDir','out',...
        'XTick', -100:20:100,...
        'Xticklabel', {[100:-20:0,20:20:100]},...
        'Xlim',[-100 100],...
        'Ytick',[], ...
        'Ylim',[0.5 4.5],...
        'Ycolor','w')
% 字体字号
set(gca, 'FontName','Arial','FontSize',10,'FontWeight','bold')
set(hTitle,'FontName','Arial','FontSize',11,'FontWeight','bold')
% 背景颜色
set(gcf,'Color',[1 1 1])

%% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'test';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');