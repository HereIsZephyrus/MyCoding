clc;clear;close all;
load Series.mat
hold on
edge=[33,61,729];
time=unique(Date);
for i=1:3
    subplot(3,1,i);
    plot(time,Time_var(edge(i),:),'b-');
    ylabel("货量");
    title(strcat(Node(Time_start(edge(i))),' to ',Node(Time_end(edge(i))),'历史数据'));
end
hold off

function str=Node(node)
    str=strcat("DC",num2str(node));
end