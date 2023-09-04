clc;clear;close all;
load Cate.mat
load Series.mat
Raise_ind=Count{7};
Raise_var=Time_var(Raise_ind,:);
[n,time]=size(Raise_var);
hold on
figure(1);
plot(1:time,Raise_var(1,:));
for i=2:n
    plot(1:time,Raise_var(i,:));
    %system("pause");
end
hold off
clear i n