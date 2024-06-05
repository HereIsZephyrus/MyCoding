clc;clear;close all;
load s2data.mat
data.pm = normalize(data.pm,"range");
%% round1
data(:,"household") = [];
%% round2
data(:,"busPassenger") = [];
%% round3
data(:,"aviationPassenger") = [];
data(:,"highwayPassenger") = [];
data(:,"birth") = [];
%% round 4
data = movevars(data,"secondaryIndustry","After","gasSupply");
data = movevars(data,"secondaryGDPRate","After","gasSupply");
data = movevars(data,"builtupArea","After","gasSupply");
%% round 5
data(:,"secondaryGDPRate") = [];
data(:,"secondaryIndustry") = [];
data(:,"GRPgrowth") = [];
%% round6
data(:,"greenRate") = [];
data(:,"builtupArea") = [];
data(:,"growthRate") = [];
%% round 7
data(:,"servicesPopulation") = [];
data(:,"electricityTotal") = [];
data(:,"gasSupply") = [];
%% round 8
data(:,"primaryGDPRate") = [];
data(:,"manufacturingPopulation") = [];
%% begin
varnames = fieldnames(data);
varnames = varnames(4:end-3);
y = table2array(data(:,4));
x = table2array(data(:,5:end));

cumname = cell(1,length(varnames)-1);
cumname{1} = varnames{2};
for i = 3:length(varnames)
    cumname{i-1} = strcat(cumname{i-2} , '+' , varnames{i});
end

for i = 3 : length(cumname)
    disp(i);
    fullModel = fitlm(data, strcat(varnames{1}, '~1+' ,cumname{i}));
    for j = 2 : i-1
        reducedModel = fitlm(data, strcat(varnames{1}, '~1+' ,cumname{j}));
        RSS_full = fullModel.SSE; 
        RSS_reduced = reducedModel.SSE;
        df_full = fullModel.DFE;
        df_reduced = reducedModel.DFE; 
        num_params_added = df_reduced - df_full;        
        F_statistic = ((RSS_reduced - RSS_full) / num_params_added) / (RSS_full / df_full);
        p_value = 1 - fcdf(F_statistic, num_params_added, df_full);
        fprintf('偏 F 检验统计量: %.4f\n', F_statistic);
        fprintf('p 值: %.4f\n', p_value);
        alpha = 0.05;
        if p_value < alpha
            fprintf('增加的变量显著，提高模型拟合。\n');
        else
            fprintf('增加的变量不显著，没有显著提高模型拟合。\n');
        end
    end
end

[b,bint,r,rint,stats] = regress(y,x);
%}