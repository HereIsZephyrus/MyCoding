%% 全体位置分布图
clc;clear;close all
load class_analysis.mat
draw(y1,x1,class,sex,"day1")
draw(y2,x2,class,sex,"day2")
draw(y3,x3,class,sex,"day3")
function draw(X,Y,class,sex,daytime)
ind_nonezero = find(X ~= 0);
X = X(ind_nonezero);
Y = Y(ind_nonezero);
class = class(ind_nonezero);
sex = sex(ind_nonezero);
ind_male = find(sex == "男");
ind_famale = find(sex == "女");
figure; 
width = 1800;  
height = 800; 
set(gcf, 'Position', [100, 100, width, height]); 
xMax = 12;
yMax = 10;

subplot(2,2,1)
ind_c1 = find(strcmp(class,'114221'));
ind_c2 = find(strcmp(class,'114222'));
ind_c3 = [find(strcmp(class,'220221'));find(strcmp(class,'220222'))];
%x_ave = mean(X);
%y_ave = mean(Y);
%scatter(x_ave,y_ave,"red","filled","square","SizeData",200);
hold on
%scatter(X,Y,'blue');
s_c1 = scatter(X(ind_c1),Y(ind_c1),100);
s_c2 = scatter(X(ind_c2),Y(ind_c2),100);
s_c3 = scatter(X(ind_c3),Y(ind_c3),100);
drawLine(xMax,yMax)
hold off
s_c1.MarkerFaceColor = [0.3010 0.7450 0.9330];
s_c2.MarkerFaceColor = [0.9290 0.6940 0.1250];
s_c3.MarkerFaceColor = [0.4940 0.1840 0.5560];
l = legend("114221","114222","220221/2","","","","","","");
l.FontSize = 14;
axis([0 xMax 0 yMax]);
t = title(daytime + "-1班级分布情况");
t.FontSize = 20;

subplot(2,2,2)
ind_s1 = intersect(ind_male,[ind_c1;ind_c2;ind_c3]);
ind_s2 = intersect(ind_famale,[ind_c1;ind_c2;ind_c3]);
hold on 
s_s1 = scatter(X(ind_s1),Y(ind_s1),100);
s_s2 = scatter(X(ind_s2),Y(ind_s2),100);
drawLine(xMax,yMax)
hold off
s_s1.MarkerFaceColor = [0 0.4470 0.7410];
s_s2.MarkerFaceColor = [0.8500 0.3250 0.0980];
l = legend("男","女","","","","","","");
l.FontSize = 14;
t = title(daytime + "-1性别分布情况");
t.FontSize = 20;

subplot(2,2,3)
ind_c4 = find(strcmp(class,'114223'));
hold on
s_c4 = scatter(X(ind_c4),Y(ind_c4),100);
drawLine(xMax,yMax)
hold off
s_c4.MarkerFaceColor = [0.3010 0.7450 0.9330];
l = legend("114223","","","","","","");
l.FontSize = 14;
axis([0 xMax 0 yMax]);
t = title(daytime + "-2班级分布情况");
t.FontSize = 20;

subplot(2,2,4)
ind_s3 = intersect(ind_male,ind_c4);
ind_s4 = intersect(ind_famale,ind_c4);
hold on 
s_s1 = scatter(X(ind_s3),Y(ind_s3),100);
s_s2 = scatter(X(ind_s4),Y(ind_s4),100);
drawLine(xMax,yMax)
hold off
s_s1.MarkerFaceColor = [0 0.4470 0.7410];
s_s2.MarkerFaceColor = [0.8500 0.3250 0.0980];
l = legend("男","女","","","","","","");
l.FontSize = 14;
t = title(daytime + "-2性别分布情况");
t.FontSize = 20;

end

