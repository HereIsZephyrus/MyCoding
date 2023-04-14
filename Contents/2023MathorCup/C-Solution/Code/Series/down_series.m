clc;clear;close all;
load Cate.mat
load Series.mat
Down_ind=Count{6};
Down_var=Time_var(Down_ind,:);
[n,time]=size(Down_var);
hold on
figure(1);
plot(1:time,Down_var(1,:));
for i=2:n
    plot(1:time,Down_var(i,:));
    %system("pause");
end
hold off
clear i n