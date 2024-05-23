clc;clear;close all
load data.mat
data.waterSupply(find(isnan(data.waterSupply))) = -1;
data.totalWaterResources(find(isnan(data.totalWaterResources))) = -1;
data.hostPop(find(isnan(data.hostPop))) = -1;
data.stayPop(find(isnan(data.stayPop))) = -1;
data.ConsummerSupply(find(isnan(data.ConsummerSupply))) = -1;
writetable(data,'filled_data.csv');