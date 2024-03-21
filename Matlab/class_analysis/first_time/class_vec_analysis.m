%% 位置迁移图
clc;clear;close all
load class_analysis.mat
% 剔除零值
no_zero = intersect(intersect(find(x1 ~= 0),find(x2 ~= 0)),find(x3 ~= 0));
class = class(no_zero);
x1 = x1(no_zero);
y1 = y1(no_zero);
x2 = x2(no_zero);
y2 = y2(no_zero);
x3 = x3(no_zero);
y3 = y3(no_zero);
dx1=zeros(length(no_zero),1);
dy1=zeros(length(no_zero),1);
dx2=zeros(length(no_zero),1);
dy2=zeros(length(no_zero),1);

% 数据预处理
ind_c1 = find(strcmp(class,'114221'));
ind_c2 = find(strcmp(class,'114222'));
ind_c3 = [find(strcmp(class,'220221'));find(strcmp(class,'220222'))];
ind_c4 = find(strcmp(class,'114223'));
ind_ct1 = [ind_c1;ind_c2;ind_c3];
ind_ct2 = ind_c4;
for i = 1 : length(no_zero)
    dx1(i) = x2(i) - x1(i);
    dy1(i) = y2(i) - y1(i);
    dx2(i) = x3(i) - x2(i);
    dy2(i) = y3(i) - y2(i);
end
% 画图
figure; 
width = 1200;  
height = 800; 
set(gcf, 'Position', [100, 100, width, height]); 
xMax = 12;
yMax = 10;
layer = ones(length(no_zero),1)*0.5;
%s_d1 = scatter3(y1 - 0.15,x1 - 0.15,layer,100,"blue","square");
%s_d2 = scatter3(y2 + 0.15,x2 - 0.15,layer*2,100,"black","^");
s= scatter3([y1(ind_ct1)-0.1,y2(ind_ct1)-0.1,y3(ind_ct1)+0.1],[x1(ind_ct1)-0.1,x2(ind_ct1)+0.1,x3(ind_ct1)],[layer(ind_ct1),layer(ind_ct1)*2,layer(ind_ct1)*3]);
s(1).Marker = "square";
s(2).Marker = '^';
s(3).Marker = 'o';
for i = 1:3
    s(i).SizeData = 100;
    s(i).LineWidth = 10;
end
clear i
hold on
ql1 = quiver3(y1(ind_ct1),x1(ind_ct1),layer(ind_ct1),dy1(ind_ct1),dx1(ind_ct1),layer(ind_ct1)*2,1.2);
ql1.LineWidth = 2;
ql1.ShowArrowHead = 'on';
ql1.Color = 'cyan';
ql2 = quiver3(y2(ind_ct1),x2(ind_ct1),layer(ind_ct1)*2,dy2(ind_ct1),dx2(ind_ct1),layer(ind_ct1)*2,1.2);
ql2.LineWidth = 2;
ql2.ShowArrowHead = 'on';
ql2.Color = 'magenta';
l = legend("第一次上课","第二次上课","第三次上课","第一次座位迁移","第二次座位迁移");
l.FontSize = 14;
hold off
axis([0 xMax 0 yMax 0.3 1.7]);
t = title("114221/114222/220221/220222三次课位置偏移情况");
t.FontSize = 20;

figure; 
width = 1200;  
height = 800; 
set(gcf, 'Position', [100, 100, width, height]); 
xMax = 12;
yMax = 10;
layer = ones(length(no_zero),1)*0.5;
s= scatter3([y1(ind_ct2)-0.1,y2(ind_ct2)-0.1,y3(ind_ct2)+0.1],[x1(ind_ct2)-0.1,x2(ind_ct2)+0.1,x3(ind_ct2)],[layer(ind_ct2),layer(ind_ct2)*2,layer(ind_ct2)*3]);
s(1).Marker = "square";
s(2).Marker = '^';
s(3).Marker = 'o';
for i = 1:3
    s(i).SizeData = 100;
    s(i).LineWidth = 10;
end
clear i

hold on
ql1 = quiver3(y1(ind_ct2),x1(ind_ct2),layer(ind_ct2),dy1(ind_ct2),dx1(ind_ct2),layer(ind_ct2)*2);
ql1.LineWidth = 2;
ql1.ShowArrowHead = 'on';
ql1.Color = 'cyan';
ql2 = quiver3(y2(ind_ct2),x2(ind_ct2),layer(ind_ct2)*2,dy2(ind_ct2),dx2(ind_ct2),layer(ind_ct2)*2);
ql2.LineWidth = 2;
ql2.ShowArrowHead = 'on';
ql2.Color = 'magenta';
l = legend("第一次上课","第二次上课","第三次上课","第一次座位迁移","第二次座位迁移");
l.FontSize = 14;
hold off
axis([0 xMax 0 yMax 0.3 1.7]);
t = title("114223三次课位置偏移情况");
t.FontSize = 20;