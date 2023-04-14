clc;clear;close all;
load Cate.mat
load Series.mat
Temp_ind=Count{2};
Temp_var=Time_var(Temp_ind,:);
[n,time]=size(Temp_var);
hold on
figure(1);
plot(1:time,Temp_var(1,:));
for i=2:n
    plot(1:time,Temp_var(i,:));
    %system("pause");
end
hold off
clear i n