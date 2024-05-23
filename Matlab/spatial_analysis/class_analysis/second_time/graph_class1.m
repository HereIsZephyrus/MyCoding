clc;clear;close all;
load adj_class1.mat

bias = 0: 0.15 : 2.25;
edgeList = cell(1,length(bias));
dpi = 300;
width = 1000;
height = 1000;
figure('units', 'normalized', 'outerposition', [0 0 1 1]);
tiledlayout(4, 4, "TileSpacing", "tight");
position = [100, 100, width, height];
set(gcf, 'Position', position);
for figure_num = 1: length(bias)
    nexttile;
    G = graph(add_bias(dis,bias(figure_num)));
    edgeList{figure_num} = G.Edges;
    plot(G, 'Layout', 'force');
    title_str = "连接强度阈值为" + num2str(bias(figure_num));
    title(title_str,FontSize=14);
end
print(gcf, '-dpng', sprintf('-r%d', dpi), 'raw_connection_class1.png');
save edgeList_class2.mat edgeList bias

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