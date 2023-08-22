%% 数据导入与处理
clc;clear;close all;
load sleepData.mat
len1=0;len2=0;
for i=1:5
   len1=max(len1,length(quality{i,1}));
   len2=max(len2,length(quality{i,2}));
end
clear i
sleep=nan(len1,5);
awake=nan(len2,5);
meanSleep=zeros(5,1);
meanAwake=zeros(5,1);
for i=1:5
    sleep(1:length(quality{i,1}),i)=quality{i,1};
    meanSleep(i)=nanmean(quality{i,1});
    awake(1:length(quality{i,2}),i)=quality{i,2};
    meanAwake(i)=nanmean(quality{i,2});
end
clear i len1 len2

C1 = [0.8929,0.2929,0.2000];
C2 = [0.3772,0.7297,0.3806];
p1=[0.5 3.5 6.5 9.5 12.5];
p2=[1.4,4.4,7.4,10.4 13.4];
hold on
%% 整晚睡眠时长绘制
yyaxis left
box_1 = boxplot(sleep,'Positions',p1,'Colors','b','Widths',0.7,'Symbol','o','Notch','on');
plot(p1,meanSleep,'-o');
hYLabel1 = ylabel('整晚睡眠时间');
set(gca,  'YColor', [.1 .1 .1],'Ylim' ,[4 13]);

%% 睡醒次数绘制
yyaxis right
box_2 = boxplot(awake,'positions',p2,'Colors','k','Widths',0.7,'Symbol','o','Notch','on');
plot(p2,meanAwake,'-o');
hYLabel2 = ylabel('睡醒次数');
set(gca,  'YColor', [.1 .1 .1],'Ylim' ,[-1 11]);

%% 细节优化
%标签
hTitle = title('各类入睡方式对婴孩睡眠情况的影响','FontSize',20);
hXLabel = xlabel('入睡方式','FontSize',14);
set(gca, 'XTick', (p1+p2)/2,...                                    % 边框
         'XGrid', 'off', 'YGrid', 'on', ...                        % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...            % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...             % 小刻度
         'XColor', [.1 .1 .1],...                                  % 坐标轴颜色
         'Xticklabel',{'哄睡法','抚摸法','安抚奶嘴法','环境营造法','定时法'})  % X轴标签
hLegend = legend([box_1(1),box_2(2)], ...
    '整晚睡眠时间', '睡醒次数', ...
    'Location', 'northeast','orientation','horizontal');
% 添加上、右框线
xc = get(gca,'XColor');
yc = get(gca,'YColor');
unit = get(gca,'units');
ax = axes( 'Units', unit,...
           'Position',get(gca,'Position'),...
           'XAxisLocation','top',...
           'YAxisLocation','right',...
           'Color','none',...
           'XColor',xc,...
           'YColor',yc);
set(ax, 'linewidth',1,...
        'XTick', [],...
        'YTick', []);