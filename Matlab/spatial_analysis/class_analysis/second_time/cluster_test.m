clc;clear;close all;
load MonteCarloResult.mat
dpi = 300;
width = 1000;
height = 1000;
Egroup_class1 = mean(MDgroup_class1);
Esex_class1 = mean(MDsex_class1);
Egroup_class2 = mean(MDgroup_class2);
Esex_class2 = mean(MDsex_class2);
E_class = mean(MD_class);
h = zeros(8,1); p = zeros(8,1);
[h(1),p(1)] = ttest2(Egroup_class1,RAWgroup_class1);
[h(2),p(2)] = ttest2(Egroup_class2,RAWgroup_class2);

pd =  fitdist(MDsex_class1(:,1),'Normal');
[h(3),p(3)] = ztest(RAWsex_class1(1),pd.mu,pd.sigma);
pd =  fitdist(MDsex_class1(:,2),'Normal');
[h(4),p(4)] = ztest(RAWsex_class1(2),pd.mu,pd.sigma);
pd =  fitdist(MDsex_class2(:,1),'Normal');
[h(5),p(5)] = ztest(RAWsex_class2(1),pd.mu,pd.sigma);
pd =  fitdist(MDsex_class2(:,2),'Normal');
[h(6),p(6)] = ztest(RAWsex_class2(2),pd.mu,pd.sigma);

pd =  fitdist(MD_class(:,1),'Normal');
[h(7),p(7)] = ztest(RAW_class(1),pd.mu,pd.sigma);
pd =  fitdist(MD_class(:,2),'Normal');
[h(8),p(8)] = ztest(RAW_class(2),pd.mu,pd.sigma);
t1 = table(h,p);
writetable(t1,"hp.xlsx");
t2 = table(RAW_class,E_class,RAWgroup_class1,Egroup_class1,RAWgroup_class2,Egroup_class2,RAWsex_class1,Esex_class1,RAWsex_class2,Esex_class2);
writetable(t2,"cluster_data.xlsx");
%%
figure('units', 'normalized', 'outerposition', [0 0 1 1]);
tiledlayout(2, 3, "TileSpacing", "tight");
position = [100, 100, width, height];
nexttile;
histfit(MDsex_class1(:,1))
title("班级1男生连接强度模拟数据直方图")
nexttile;
histfit(MDsex_class1(:,2))
title("班级1女生连接强度模拟数据直方图")
nexttile;
histfit(MD_class(:,1))
title("114221连接强度模拟数据直方图")
nexttile;
histfit(MDsex_class2(:,1))
title("班级2男生连接强度模拟数据直方图")
nexttile;
histfit(MDsex_class2(:,2))
title("班级2女生连接强度模拟数据直方图")
nexttile;
histfit(MD_class(:,2))
title("114222连接强度模拟数据直方图")
print(gcf, '-dpng', sprintf('-r%d', dpi), 'normal_histogram.png');