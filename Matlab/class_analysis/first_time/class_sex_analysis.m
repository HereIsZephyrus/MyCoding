%% 位置迁移图
clc;clear;close all
load class_analysis.mat
% 剔除零值
no_zero = intersect(intersect(find(x1 ~= 0),find(x2 ~= 0)),find(x3 ~= 0));
class = class(no_zero);
sex = sex(no_zero);
x1 = x1(no_zero);
y1 = y1(no_zero);
x2 = x2(no_zero);
y2 = y2(no_zero);
x3 = x3(no_zero);
y3 = y3(no_zero);

% 数据预处理
ind_male = find(sex == "男");
ind_famale = find(sex == "女");
ind_c1 = find(strcmp(class,'114221'));
ind_c2 = find(strcmp(class,'114222'));
ind_c3 = [find(strcmp(class,'220221'));find(strcmp(class,'220222'))];
ind_c4 = find(strcmp(class,'114223'));
ind_ct1 = [ind_c1;ind_c2;ind_c3];
ind_ct2 = ind_c4;

xMax = 12;
yMax = 10;
layer = ones(length(no_zero),1)*0.5;
%%%%%
ind_male = find(sex(ind_ct2) == "男");
ind_famale = find(sex(ind_ct2) == "女");
p_male = zeros(length(ind_male),3,3);
p_famale = zeros(length(ind_famale),3,3);
m_male = zeros(3,3);
m_famale = zeros(3,3);
m_total = zeros(3,3);
layer1 = 1;layer2 = 2;layer3 = 3;
xaxis = 1; yaxis = 2; zaxis = 3;
for i = 1 : length(ind_male)
    p_male(i,layer1,xaxis) = x1(ind_male(i));
    p_male(i,layer2,xaxis) = x2(ind_male(i));
    p_male(i,layer3,xaxis) = x3(ind_male(i));
    p_male(i,layer1,yaxis) = y1(ind_male(i));
    p_male(i,layer2,yaxis) = y2(ind_male(i));
    p_male(i,layer3,yaxis) = y3(ind_male(i));
    p_male(i,layer1,zaxis) = layer1/2;
    p_male(i,layer2,zaxis) = layer2/2;
    p_male(i,layer3,zaxis) = layer3/2;
end
for l = 1:3
    for ax = 1:3
        m_male(l,ax) = mean(p_male(:,l,ax));
    end
end
clear i l ax
for i = 1 : length(ind_famale)
    p_famale(i,layer1,xaxis) = x1(ind_famale(i));
    p_famale(i,layer2,xaxis) = x2(ind_famale(i));
    p_famale(i,layer3,xaxis) = x3(ind_famale(i));
    p_famale(i,layer1,yaxis) = y1(ind_famale(i));
    p_famale(i,layer2,yaxis) = y2(ind_famale(i));
    p_famale(i,layer3,yaxis) = y3(ind_famale(i));
    p_famale(i,layer1,zaxis) = layer1/2;
    p_famale(i,layer2,zaxis) = layer2/2;
    p_famale(i,layer3,zaxis) = layer3/2;
end
for l = 1:3
    for ax = 1:3
        m_famale(l,ax) = mean(p_famale(:,l,ax));
    end
end
clear i l ax
for l = 1:3
    for ax = 1:3
        m_total(l,ax) = mean([p_famale(:,l,ax);p_male(:,l,ax)]);
    end
end
clear l ax
% 画图
figure; 
width = 1200;   
height = 800; 
set(gcf, 'Position', [100, 100, width, height]); 
s_male = scatter3(  [p_male(:,layer1,yaxis);p_male(:,layer2,yaxis);p_male(:,layer3,yaxis)], ...
                    [p_male(:,layer1,xaxis);p_male(:,layer2,xaxis);p_male(:,layer3,xaxis)], ...
                    [p_male(:,layer1,zaxis);p_male(:,layer2,zaxis);p_male(:,layer3,zaxis)]);
hold on
s_famale = scatter3([p_famale(:,layer1,yaxis);p_famale(:,layer2,yaxis);p_famale(:,layer3,yaxis)], ...
                    [p_famale(:,layer1,xaxis);p_famale(:,layer2,xaxis);p_famale(:,layer3,xaxis)], ...
                    [p_famale(:,layer1,zaxis);p_famale(:,layer2,zaxis);p_famale(:,layer3,zaxis)]);
q_male = quiver3( ...
    [p_male(:,layer1,yaxis),p_male(:,layer2,yaxis)], ...
    [p_male(:,layer1,xaxis),p_male(:,layer2,xaxis)], ...
    [p_male(:,layer1,zaxis),p_male(:,layer2,zaxis)], ...
    [p_male(:,layer2,yaxis)-p_male(:,layer1,yaxis),p_male(:,layer3,yaxis)-p_male(:,layer2,yaxis)], ...
    [p_male(:,layer2,xaxis)-p_male(:,layer1,xaxis),p_male(:,layer3,xaxis)-p_male(:,layer2,xaxis)], ...
    [p_male(:,layer2,zaxis)-p_male(:,layer1,zaxis),p_male(:,layer3,zaxis)-p_male(:,layer2,zaxis)],0.6);
q_famale = quiver3( ...
    [p_famale(:,layer1,yaxis),p_famale(:,layer2,yaxis)], ...
    [p_famale(:,layer1,xaxis),p_famale(:,layer2,xaxis)], ...
    [p_famale(:,layer1,zaxis),p_famale(:,layer2,zaxis)], ...
    [p_famale(:,layer2,yaxis)-p_famale(:,layer1,yaxis),p_famale(:,layer3,yaxis)-p_famale(:,layer2,yaxis)], ...
    [p_famale(:,layer2,xaxis)-p_famale(:,layer1,xaxis),p_famale(:,layer3,xaxis)-p_famale(:,layer2,xaxis)], ...
    [p_famale(:,layer2,zaxis)-p_famale(:,layer1,zaxis),p_famale(:,layer3,zaxis)-p_famale(:,layer2,zaxis)],0.6);
s_male_mean = scatter3(m_male(:,yaxis),m_male(:,xaxis),m_male(:,zaxis));
s_famale_mean = scatter3(m_famale(:,yaxis),m_famale(:,xaxis),m_famale(:,zaxis));
s_total_mean = scatter3(m_total(:,yaxis),m_total(:,xaxis),m_total(:,zaxis));
q_male_mean = quiver3( ...
    [m_male(layer1,yaxis),m_male(layer2,yaxis)], ...
    [m_male(layer1,xaxis),m_male(layer2,xaxis)], ...
    [m_male(layer1,zaxis),m_male(layer2,zaxis)], ...
    [m_male(layer2,yaxis)-m_male(layer1,yaxis),m_male(layer3,yaxis)-m_male(layer2,yaxis)], ...
    [m_male(layer2,xaxis)-m_male(layer1,xaxis),m_male(layer3,xaxis)-m_male(layer2,xaxis)], ...
    [m_male(layer2,zaxis)-m_male(layer1,zaxis),m_male(layer3,zaxis)-m_male(layer2,zaxis)],'off');
q_famale_mean = quiver3( ...
    [m_famale(layer1,yaxis),m_famale(layer2,yaxis)], ...
    [m_famale(layer1,xaxis),m_famale(layer2,xaxis)], ...
    [m_famale(layer1,zaxis),m_famale(layer2,zaxis)], ...
    [m_famale(layer2,yaxis)-m_famale(layer1,yaxis),m_famale(layer3,yaxis)-m_famale(layer2,yaxis)], ...
    [m_famale(layer2,xaxis)-m_famale(layer1,xaxis),m_famale(layer3,xaxis)-m_famale(layer2,xaxis)], ...
    [m_famale(layer2,zaxis)-m_famale(layer1,zaxis),m_famale(layer3,zaxis)-m_famale(layer2,zaxis)],'off');
q_total_mean = quiver3( ...
    [m_total(layer1,yaxis),m_total(layer2,yaxis)], ...
    [m_total(layer1,xaxis),m_total(layer2,xaxis)], ...
    [m_total(layer1,zaxis),m_total(layer2,zaxis)], ...
    [m_total(layer2,yaxis)-m_total(layer1,yaxis),m_total(layer3,yaxis)-m_total(layer2,yaxis)], ...
    [m_total(layer2,xaxis)-m_total(layer1,xaxis),m_total(layer3,xaxis)-m_total(layer2,xaxis)], ...
    [m_total(layer2,zaxis)-m_total(layer1,zaxis),m_total(layer3,zaxis)-m_total(layer2,zaxis)],'off');
hold off
% 调整
s_male.MarkerFaceColor = [0 0.4470 0.7410];
s_male.SizeData = 100;
s_male.MarkerFaceAlpha = 0.4;
s_famale.MarkerFaceColor = [0.8500 0.3250 0.0980];
s_famale.SizeData = 100;
s_famale.MarkerFaceAlpha = 0.4;
s_male_mean.MarkerFaceColor = 'blue';
s_male_mean.SizeData = 250;
s_male_mean.Marker = 'hexagram';
s_famale_mean.MarkerFaceColor = 'red';
s_famale_mean.SizeData = 250;
s_famale_mean.Marker = 'hexagram';
s_total_mean.MarkerFaceColor = [0.6350 0.0780 0.1840];
s_total_mean.SizeData = 250;
s_total_mean.Marker = 'pentagram';
q_male.LineWidth = 2;
q_male.ShowArrowHead = 'on';
q_male.Color = [0 1 1 0.2];
q_famale.LineWidth = 2;
q_famale.ShowArrowHead = 'on';
q_famale.Color = [1 0 1 0.2];
q_male_mean.LineWidth = 2.5;
q_male_mean.Color = 'blue';
q_famale_mean.LineWidth = 2.5;
q_famale_mean.Color = 'red';
q_total_mean.LineWidth = 2.5;
q_total_mean.Color = [0.6350 0.0780 0.1840];
l = legend("男","女","男生位置迁移","女生位置迁移","男生位置重心","女生位置重心","总体重心");
l.FontSize = 14;
axis([0 xMax 0 yMax 0.3 1.7]);
%t = title("114221/114222/220221/220222三次课位置偏移情况");
t = title("114223三次课位置偏移情况");
t.FontSize = 20;
