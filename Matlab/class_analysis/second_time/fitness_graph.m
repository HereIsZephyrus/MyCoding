clc;clear;close all;
load class_info.mat
dpi = 300;
width =600;
height = 600;
kth = 3;
figure('units', 'normalized', 'outerposition', [0 0 1 1]);
tiledlayout(1, 2, "TileSpacing", "compact");
position = [100, 100, width, height];
set(gcf, 'Position', position);
class_color1 = [0.9373,0.5412,0.3843];
class_color2 = [0.4039,0.6627,0.8118];
class_color3 = [0.1059,0.6196,0.4667];
class_color4 = [0.4588,0.4392,0.7020];
%% class1
load adj_class1.mat
nexttile
bias = 1.42;
G = graph(add_bias(dis,bias));
weights = G.Edges.Weight;
[~,weight_id] = sort(weights);
colorMap = addcolorplus(275);
colorMap = colorMap(weight_id,:);
len = 75;
class_info = basic_info(1:len,:);
p_line = plot(G, 'Layout', 'auto','EdgeColor',colorMap,'LineWidth',2.5,'EdgeAlpha',1,'NodeFontSize',10,'MarkerSize',1);
male_ind = find(class_info.sex == '男');
famale_ind = find(class_info.sex == '女');
max_x = max(p_line.XData);
max_y = max(p_line.YData);
male_x = p_line.XData(male_ind);
male_y = p_line.YData(male_ind);
famale_x = p_line.XData(famale_ind);
famale_y = p_line.YData(famale_ind);
hold on 
faceColor = repmat(class_color3,len,1);
class_id = find(class_info.class == "114221");
faceColor(class_id,:) = repmat(class_color1,length(class_id),1);
class_id = find(class_info.class == "114222");
faceColor(class_id,:) = repmat(class_color2,length(class_id),1);
clear class_id
p_male = scatter(male_x,male_y,100,faceColor(male_ind,:),'filled','Marker','square','MarkerEdgeColor','white','LineWidth',1);
p_famale = scatter(famale_x,famale_y,100,faceColor(famale_ind,:),'filled','Marker','^','MarkerEdgeColor','white','LineWidth',1);
clear i
hold off
legend('座位相关性','男','女',fontsize = 14);
rectangle('Position', [max_x-0.38, max_y-0.1, 0.2, 0.15], 'FaceColor', class_color1);
rectangle('Position', [max_x-0.38, max_y-0.5, 0.2, 0.15], 'FaceColor', class_color2);
rectangle('Position', [max_x-0.38, max_y-0.9, 0.2, 0.15], 'FaceColor', class_color3);
annotation('textbox', [0.42, 0.82, 0.06, 0.02], 'String', '     114221');
annotation('textbox', [0.42, 0.80, 0.06, 0.02], 'String', '     114222');
annotation('textbox', [0.42, 0.78, 0.06, 0.02], 'String', '     220221-2');
title("114221/114222/220221-2理论阈值分组",FontSize=18);
%% class2
load adj_class2.mat
nexttile
bias = 0.87;
G = graph(add_bias(dis,bias));
weights = G.Edges.Weight;
[~,weight_id] = sort(weights);
colorMap = addcolorplus(275);
colorMap = colorMap(weight_id,:);
len = 34;
class_info = basic_info(110-len:109,:);
p_line = plot(G, 'Layout', 'force','EdgeColor',colorMap,'LineWidth',2.5,'EdgeAlpha',1,'NodeFontSize',10,'MarkerSize',1);
male_ind = find(class_info.sex == '男');
famale_ind = find(class_info.sex == '女');
male_x = p_line.XData(male_ind);
male_y = p_line.YData(male_ind);
famale_x = p_line.XData(famale_ind);
famale_y = p_line.YData(famale_ind);
hold on 
p_male = scatter(male_x,male_y,100,faceColor(male_ind,:),'filled','Marker','square','MarkerEdgeColor','white','LineWidth',1,'MarkerFaceColor',class_color4);
p_famale = scatter(famale_x,famale_y,100,faceColor(famale_ind,:),'filled','Marker','^','MarkerEdgeColor','white','LineWidth',1,'MarkerFaceColor',class_color4);
legend('座位相关性','男','女',fontsize = 14);
hold off
title("114223理论阈值分组",FontSize=18);

function res_matrix = add_bias(raw_matrix,bias)
    n = length(raw_matrix);
    res_matrix = raw_matrix;
    for i = 1 : n
        for j = 1 : n
            if (res_matrix(i,j)<bias)
                res_matrix(i,j) = 0;
            end
        end
    end
end