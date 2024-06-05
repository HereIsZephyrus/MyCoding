clc;clear;close all;
load s1data.mat
R = cell(1,6); P = cell(1,6); D = cell(1,6); varname = cell(1,6);
figureHandle = figure;
map = addcolorplus(299);
tiledlayout(3,2);
totalname = {};
for i = 1:5
    nexttile;
    ind = i + 4;
    t = data(:,ind);
    tName = fieldnames(t);
    tName = tName{1};
    t = t{:,tName};

    D{i} = table2array(t);
    D{i} = normalize(D{i},"range");
    D{6} = [D{6} D{i}];
    [R{i},P{i}] = corrcoef(D{i},'Alpha',0.05);

    varNames = fieldnames(t);
    varNum = length(P{i});
    varname{i} = varNames(1:varNum);
    xvalues = varname{i};
    yvalues = varname{i};
    totalname(end+1:end+varNum) = varname{i};
    h = heatmap(xvalues,yvalues,R{i},"FontSize",8,'Colormap',map);
    %h = heatmap(xvalues,yvalues, P{i}, 'FontSize',8, 'FontName','Helvetica');
    h.Title = tName;
    h.CellLabelColor = 'none';
    set(gcf,'Color',[1 1 1]);
end
nexttile;
[R{6},P{6}] = corrcoef(D{6},'Alpha',0.05);
varname{6} = totalname;
xvalues = totalname;
yvalues = totalname;
h = heatmap(xvalues,yvalues,R{6},"FontSize",4,'Colormap',map);
h.Title = "total";
h.CellLabelColor = 'none';
set(gcf,'Color',[1 1 1]);
annotation('textbox',[0.1 0.95 0.8 0.05],'String','各指标内相关系数热图', ...
    'EdgeColor','none','HorizontalAlignment','center',"FontSize",20);
save totalvar.mat R P varname D