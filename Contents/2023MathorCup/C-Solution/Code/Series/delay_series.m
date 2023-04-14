clc;clear;close all;
load Cate.mat
load Series.mat
Delay_ind=Count{3};
Delay_var=Time_var(Delay_ind,:);
[n,time]=size(Delay_var);
hold on
figure(1);
plot(1:time,Delay_var(1,:));
for i=2:n
    plot(1:time,Delay_var(i,:));
    %system("pause");
end
hold off
clear i n