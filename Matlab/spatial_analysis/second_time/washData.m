clc;clear;close all
load data.mat

f = figure;
tiledlayout(3,2);
for ind = 5:10
    %subplot(3,2,ind-4);
    nexttile;
    t = data(:,ind);
    tName = fieldnames(t);
    tName = tName{1};
    t = t{:,tName};
    countAbsent(t,tName);
end
annotation('textbox',[0.1 0.95 0.8 0.05],'String','各城市各指标缺失情况', ...
    'EdgeColor','none','HorizontalAlignment','center',"FontSize",20);

function countAbsent(t,name)
    [len,varNum] = size(t);
    varNames = fieldnames(t);
    varNames = varNames(1:varNum);
    absentNum = zeros(1,varNum);
    for var = 1:varNum
        col = table2array(t(:,var));
        absentNum(var) = length(find(isnan(col)) == 1);
    end
    hold on
    b = bar(absentNum);
    xx = linspace(0,20,11);
    plot(xx,repmat(len * 0.05,1,length(xx)),'LineWidth',2,'Color','red');
    plot(xx,repmat(len * 0.1,1,length(xx)),'LineWidth',2,'Color','magenta');
    legend("缺失值数量","5%阈值","10%阈值");
    hold off
    xlim([0 varNum+1]);
    xticks(1:1:varNum);
    xticklabels(varNames);
    ax=gca;
    %ax.YAxis.Visible='off';
    title(name,FontSize=14);
end