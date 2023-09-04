clc;clear;close all;
load Cate.mat
load Series.mat
Normal_ind=Count{1};
Normal_var=Time_var(Normal_ind,:);
[n,time]=size(Normal_var);
hold on
figure(1);
plot(1:time,Normal_var(1,:));
for i=2:n
    plot(1:time,Normal_var(i,:));
    %system("pause");
end
hold off
clear i n