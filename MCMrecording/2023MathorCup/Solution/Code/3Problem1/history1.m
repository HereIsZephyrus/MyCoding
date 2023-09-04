clc;clear;close all;
load Problem1.mat
hold on
path(1,1)=14;path(1,2)=10;
path(2,1)=20;path(2,2)=35;
path(3,1)=25;path(3,2)=62;
for i=1:3
    subplot(3,1,i);
    plot(1:length(result{i}),result{i},'b-');
    ylabel("货量");
    title(strcat(Node(path(i,1)),' to ',Node(path(i,2)),'历史数据清理结果'));
end
hold off

function str=Node(node)
    str=strcat("DC",num2str(node));
end