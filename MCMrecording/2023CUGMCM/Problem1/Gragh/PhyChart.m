%% 数据导入与处理
clc;clear;close all;
load rawData.mat
ind1=find(cateData.Marriage==2);
ind2=find(cateData.Marriage==1);
marrT=cateData(ind1,:);
unmarrT=cateData(ind2,:);
marr=[marrT.CBTS,marrT.EPDS,marrT.HADS];
unmarr=[unmarrT.CBTS,unmarrT.EPDS,unmarrT.HADS];
meanMarr=mean(marr,1);
meanUnmarr=mean(unmarr,1);

C1 = [0.8929,0.2929,0.2000];
C2 = [0.3772,0.7297,0.3806];
p1=[0.5 3.5 6.5];
%p2=[1.4,4.4,7.4];
p2=p1;
hold on
%% 绘制
%box_1 = boxplot(marr,'Positions',p1,'Colors','b','Widths',0.7,'Symbol','o');
plot1=plot(p1,meanMarr,'-o');
%box_2 = boxplot(unmarr,'positions',p2,'Colors','k','Widths',0.7,'Symbol','o');
plot(p2,meanUnmarr,'-o');
set(gca,  'YColor', [.1 .1 .1],'Ylim' ,[0 30]);

%% 细节优化
%标签
hTitle = title('不同婚姻情况的产妇心理量表结果','FontSize',20);
hXLabel = xlabel('量表名称','FontSize',14);
hYLabel1 = ylabel('分数');
set(gca, 'XTick', (p1+p2)/2,...                                    % 边框
         'XGrid', 'off', 'YGrid', 'on', ...                        % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...            % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...             % 小刻度
         'XColor', [.1 .1 .1],...                                  % 坐标轴颜色
         'Xticklabel',{'CBTS','EPDS','HADS'})  % X轴标签
hLegend = legend([box_1(1),box_2(2)], ...
    '已婚', '未婚', ...
    'Location', 'northeast','orientation','horizontal');