clc;clear;close all;
load soil-data.mat
name = data.id;
American.clay = data.mius001 + data.b001002;
American.silt =  data.b00201 + data.b0105;
American.sand = data.b0510 + data.b1020;
China.clay = data.mius001;
China.silt = data.b0105;
China.sand = data.b0510;
sta = STernary();
%% 美国分类标准
sta.label2Side()
set(sta,'A_Label','String','Perent of silt');
set(sta,'B_Label','String','Perent of sand');
set(sta,'C_Label','String','Perent of clay');
sta.set('MinorGridValues',5:5:100);
sta.set('MinorTickValues',2.5:2.5:100);
set(sta,'A_Grid','Color',[0.5,0.5,0.5],'LineWidth',1)
set(sta,'B_Grid','Color',[0.5,0.5,0.5],'LineWidth',1)
set(sta,'C_Grid','Color',[0.5,0.5,0.5],'LineWidth',1)

text_finetuning = zeros(length(name),3);
text_finetuning(1,:) = [-2,5,-5];
text_finetuning(2,:) = [1,3,1];
text_finetuning(4,:) = [-2,5,0];
text_finetuning(6,:) = [0,-5,-2];
text_finetuning(8,:) = [-2,10,3];
text_finetuning(10,:) = [0,5,0];
for i = 1 : length(name)
    sta.SScatter(American.silt(i),American.sand(i),American.clay(i),40,'filled','CData',[0,0,0.8]);
    sta.SText(American.silt(i)+text_finetuning(i,1),American.sand(i)+text_finetuning(i,2),American.clay(i)+text_finetuning(i,3),name(i),'FontSize',14);
end

sta.SPlot([1.5,0],[4.5,4.5],[4,5.5],'LineWidth',2,'Color',[0,0,0]);
sta.SPlot([1.5,6],[4.5,0],[4,4],'LineWidth',2,'Color',[0,0,0]);
sta.SPlot([1.5,2.75],[4.5,4.5],[4,2.75],'LineWidth',2,'Color',[0,0,0]);
sta.SPlot([4,4],[2,0],[4,6],'LineWidth',2,'Color',[0,0,0]);
sta.SPlot([2,0],[4.5,6.5],[3.5,3.5],'LineWidth',2,'Color',[0,0,0]);
sta.SPlot([4,5.25],[2,2],[4,2.75],'LineWidth',2,'Color',[0,0,0]);
sta.SPlot([5,5],[2.25,5],[2.75,0],'LineWidth',2,'Color',[0,0,0]);
sta.SPlot([7.25,2.75],[0,4.5],[2.75,2.75],'LineWidth',2,'Color',[0,0,0]);
sta.SPlot([8,8.75],[0.75,0],[1.25,1.25],'LineWidth',2,'Color',[0,0,0]);
sta.SPlot([8,8],[0.75,2],[1.25,0],'LineWidth',2,'Color',[0,0,0]);
sta.SPlot([2.75,2.75],[5.25,4.5],[2,2.75],'LineWidth',2,'Color',[0,0,0]);
sta.SPlot([2.75,4],[5.25,5.25],[2,0.75],'LineWidth',2,'Color',[0,0,0]);
sta.SPlot([2.75,0],[5.25,8],[2,2],'LineWidth',2,'Color',[0,0,0]);
sta.SPlot([4,5],[5.25,4.25],[0.75,0.75],'LineWidth',2,'Color',[0,0,0]);
sta.SPlot([0,3],[8.5,7],[1.5,0],'LineWidth',2,'Color',[0,0,0]);
sta.SPlot([0,1.5],[9,8.5],[1,0],'LineWidth',2,'Color',[0,0,0]);

%sta.SText(2.2,2.2,5.6,"clay","FontSize",16);
%sta.SText(4.7,0.8,4.5,"slity" + newline + "clay","FontSize",16);
%sta.SText(0.7,5.6,3.7,"sandy" + newline + "clay","FontSize",16);
%sta.SText(5,1.5,3.5,"slity" + newline + "clay loam","FontSize",16);
%sta.SText(2.5,4,3.5, "clay loam","FontSize",16);
%sta.SText(2.2,2.2,5.6, "silt loam","FontSize",16);
%sta.SText(2.2,2.2,5.6, "sandy loam","FontSize",16);
%sta.SText(2.2,2.2,5.6, "loam","FontSize",16);
%sta.SText(2.2,2.2,5.6, "silt","FontSize",16);
