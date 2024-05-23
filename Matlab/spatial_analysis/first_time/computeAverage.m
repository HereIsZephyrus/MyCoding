clc;clear;close all;
load cleaned-data.mat
%% 标准化数据
totalHostPop = sum(data.hostPop);
totalStayPop = sum(data.stayPop);
totalConsume = sum(data.consummerSupply);
totalResource = sum(data.resource);
totalSupply = sum(data.supply);

stdHostPop = sort(data.hostPop / totalHostPop);
stdStayPop = sort(data.stayPop / totalStayPop);
stdConsume = sort(data.consummerSupply / totalConsume);
stdResource = sort(data.resource / totalResource);
stdSupply = sort(data.supply / totalSupply);

yHostPop = cumsum(stdHostPop);
yStayPop = cumsum(stdStayPop);
yConsume = cumsum(stdConsume);
yResource = cumsum(stdResource);
ySupply = cumsum(stdSupply);

%% 拟合洛伦兹曲线
consumeAve = data.consummerSupply ./ data.stayPop;
containAve = data.resource ./ data.hostPop;
supplyAve = data.supply ./ data.stayPop;
save aveData.mat consumeAve containAve supplyAve

consumeFit = fit(yStayPop,yConsume,'smoothingspline');
containFit = fit(yHostPop,yResource,'smoothingspline');
supplyFit = fit(yStayPop,ySupply,'smoothingspline');

%% 插值算基尼系数
len = length(data.cityName);
unit = 1000;
xx = linspace(0,1,unit);

f = figure;

subplot(1,3,1);
geni = round((1 - trapz(xx,consumeFit(xx)) * 2)*100)/100;
hold on
area(xx,xx,'FaceColor',colorplus(285),'FaceAlpha',0.3,'EdgeColor','none');
plot([0,1],[0,1],'LineStyle','--','LineWidth',1.5,'Color',[0,0,0]);
area(xx,consumeFit(xx),'FaceColor',colorplus(40),'FaceAlpha',0.3,'EdgeColor','none');
plot(xx,consumeFit(xx),'LineStyle','-','LineWidth',1.5,'Color','blue');
legend("","均匀分布","","实际分布",'Location','northwest');
text(0.02,0.7,strcat("基尼系数=",num2str(geni)),FontSize=14);
hold off
axis equal
grid on
axis([0,1,0,1])
ax=gca;
yticks(0:0.2:1);
ylabel("累进比率")
xticks(0:0.2:1);
xticklabels(["0","20","40","60","80","100"]);
title("全国城市(部分)人均居民售水量洛伦兹曲线",FontSize=14);

subplot(1,3,2);
geni = round((1 - trapz(xx,supplyFit(xx)) * 2)*100)/100;
hold on
area(xx,xx,'FaceColor',colorplus(285),'FaceAlpha',0.3,'EdgeColor','none');
plot([0,1],[0,1],'LineStyle','--','LineWidth',1.5,'Color',[0,0,0]);
area(xx,supplyFit(xx),'FaceColor',colorplus(40),'FaceAlpha',0.3,'EdgeColor','none');
plot(xx,supplyFit(xx),'LineStyle','-','LineWidth',1.5,'Color','blue');
legend("","均匀分布","","实际分布",'Location','northwest');
text(0.02,0.7,strcat("基尼系数=",num2str(geni)),FontSize=14);
hold off
axis equal
grid on
axis([0,1,0,1])
ax=gca;
yticks(0:0.2:1);
ylabel("累进比率")
xticks(0:0.2:1);
xticklabels(["0","20","40","60","80","100"]);
title("全国城市(部分)人均售水量洛伦兹曲线",FontSize=14);

subplot(1,3,3);
geni = round((1 - trapz(xx,containFit(xx)) * 2)*100)/100;
hold on
area(xx,xx,'FaceColor',colorplus(285),'FaceAlpha',0.3,'EdgeColor','none');
plot([0,1],[0,1],'LineStyle','--','LineWidth',1.5,'Color',[0,0,0]);
area(xx,containFit(xx),'FaceColor',colorplus(40),'FaceAlpha',0.3,'EdgeColor','none');
plot(xx,containFit(xx),'LineStyle','-','LineWidth',1.5,'Color','blue');
legend("","均匀分布","","实际分布",'Location','northwest');
text(0.02,0.7,strcat("基尼系数=",num2str(geni)),FontSize=14);
hold off
axis equal
grid on
axis([0,1,0,1])
ax=gca;
yticks(0:0.2:1);
ylabel("累进比率")
xticks(0:0.2:1);
xticklabels(["0","20","40","60","80","100"]);
title("全国城市(部分)人均水资源拥有量洛伦兹曲线",FontSize=14);