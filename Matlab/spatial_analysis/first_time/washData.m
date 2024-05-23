clc;clear;close all
load data.mat
format shortG
provinces = unique(data.provinceID);
len = length(provinces);
countNan = zeros(1,len);
countTot = zeros(1,len);
checkAbandon = zeros(1,len);
colormap = colorplus([193,189,337,374]);
for i = 1 : len
    index = find(data.provinceID == provinces(i));
    provinceData = data(index,:);
    countName(i) = data.provinceName(index(1));
    staticData = table2array(provinceData(:,6:7));
    countTot(i) = numel(staticData);
    countNan(i) = numel(find(isnan(staticData)));
    if (countNan(i)/countTot(i) >= 0.4)
        checkAbandon(i) = 1;
    end
end
toAbandon = find(checkAbandon);

b = bar(countTot,'FaceColor','flat');
b.CData = repmat(colormap(1,:),len,1);
b.CData(toAbandon,:) = repmat(colormap(2,:),length(toAbandon),1);
xtips = b.XEndPoints;
ytips = b.YEndPoints;
labels = cell(1,len);
for i = 1 : len
    labels{i} = num2str(round((countNan(i) / countTot(i)) * 100) / 100);
end
text(xtips - 0.5,ytips + 1,labels);
hold on
b = bar(countNan,'FaceColor','flat');
b.CData = repmat(colormap(3,:),len,1);
b.CData(toAbandon,:) = repmat(colormap(4,:),length(toAbandon),1);
hold off
xticks(1:1:31);
xticklabels(countName);
ax=gca;
ax.YAxis.Visible='off';
title("各省统计数据缺失值情况",FontSize=14);

save data.mat data toAbandon provinces