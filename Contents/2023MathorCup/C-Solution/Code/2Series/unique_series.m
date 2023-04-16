clc;clear;close all;
load Cate.mat
load Series.mat
Unique_ind=Count{5};
Unique_var=Time_var(Unique_ind,:);
[n,time]=size(Unique_var);
hold on
figure(1);
plot(1:time,Unique_var(1,:));
for i=2:n
    plot(1:time,Unique_var(i,:));
    %system("pause");
end
hold off
clear i n