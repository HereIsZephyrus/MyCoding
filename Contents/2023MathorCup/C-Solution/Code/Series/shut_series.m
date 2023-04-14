clc;clear;close all;
load Cate.mat
load Series.mat
Shut_ind=Count{4};
Shut_var=Time_var(Shut_ind,:);
[n,time]=size(Shut_var);
hold on
figure(1);
plot(1:time,Shut_var(1,:));
for i=2:n
    plot(1:time,Shut_var(i,:));
    %system("pause");
end
hold off
clear i n