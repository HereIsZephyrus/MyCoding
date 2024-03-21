clc;clear;close all;
dpi = 300;
width =600;
height = 600;
kth = 3;
figure('units', 'normalized', 'outerposition', [0 0 1 1]);
tiledlayout(1, 2, "TileSpacing", "tight");
position = [100, 100, width, height];
set(gcf, 'Position', position);
%% class1
load adj_class1.mat
res_lowerbound = 1.23;
res = rms(dis,2);
id = find(res>res_lowerbound);
dis = dis(id,id);
len = length(dis);
vec = reshape(dis,1,len*len);
[cdf,x] = ecdf(vec);
nexttile;
semilogx(x,cdf,'b-*');
xlabel("相对连接强度(对数)");
ylabel("CDF");
title("114221/114222/220221-2连接强度累计分布",FontSize=14);
%nexttile;
%plot(x,cdf);
%xlabel("相对连接强度");
%ylabel("CDF");
%title("114221/114222/220221-2连接强度累计分布",FontSize=14);
clear dis;
%% class2
load adj_class2.mat
res_lowerbound = 0.49;
res = rms(dis,2);
id = find(res>res_lowerbound);
dis = dis(id,id);
len = length(dis);
vec = reshape(dis,1,len*len);
[cdf,x] = ecdf(vec);
nexttile;
semilogx(x,cdf,'b-*');
xlabel("相对连接强度(对数)");
ylabel("CDF");
title("114223连接强度累计分布",FontSize=14);
%nexttile;
%plot(x,cdf);
%xlabel("相对连接强度");
%ylabel("CDF");
%title("114223连接强度累计分布",FontSize=14);

%print(gcf, '-dpng', sprintf('-r%d', dpi), 'strength_CDF.png');