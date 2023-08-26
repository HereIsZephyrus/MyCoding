clc; close all; clear;
%这里是问题二的路段,是否刹车
data1 = xlsread('E:\1数学建模2023\2023国赛（）\第三次培训\问题二\路段1.xlsx');
data2 = xlsread('E:\1数学建模2023\2023国赛（）\第三次培训\问题二\路段2.xlsx');
data3 = xlsread('E:\1数学建模2023\2023国赛（）\第三次培训\问题二\路段3.xlsx');
data4 = xlsread('E:\1数学建模2023\2023国赛（）\第三次培训\问题二\路段4.xlsx');
%%
v1 = data1(:, 5);
a1 = data1(:, 8);

% 初始化计数器和刹车标志列
brake_counter = 0;
is_braking = zeros(size(v1));  % 新的列，默认为0

for i = 2:length(v1)-1
    if (v1(i)>v1(i-1) || a1(i) < 0)&&(v1(i)<v1(i-1) || a1(i)>0) 
         
        brake_counter = brake_counter + 1;
        is_braking(i) = 1;  % 将对应位置的刹车标志设置为1
    end
end

% 打印刹车次数
fprintf('刹车次数：%d\n', brake_counter);

% 将刹车标志列添加到v1的新一列
v1_with_braking = [v1, is_braking];

% v1(i) < v1(i-1) && v1(i) < v1(i+1)
%%
clear i
v2 = data2(:, 5);
a2 = data2(:, 8);
% 初始化计数器和刹车标志列
brake_counter = 0;
is_braking = zeros(size(v2));  % 新的列，默认为0

for i = 2:length(v1)-1
    if (v2(i)>v2(i-1) || a2(i) < 0)&& (v2(i)<v2(i-1)  || a2(i)>0)
        brake_counter = brake_counter + 1;
        is_braking(i) = 1;  % 将对应位置的刹车标志设置为1
    end
end

% 打印刹车次数
fprintf('刹车次数：%d\n', brake_counter);

% 将刹车标志列添加到v1的新一列
v2_with_braking = [v2, is_braking];
%%
clear i
v3 = data3(:, 5);
a3 = data3(:, 8);
% 初始化计数器和刹车标志列
brake_counter = 0;
is_braking = zeros(size(v3));  % 新的列，默认为0

for i = 2:length(v1)-1
    if (v3(i)>v3(i-1) || a3(i) < 0)&&(v3(i)<v3(i-1) || a3(i)>0)
        brake_counter = brake_counter + 1;
        is_braking(i) = 1;  % 将对应位置的刹车标志设置为1
    end
end

% 打印刹车次数
fprintf('刹车次数：%d\n', brake_counter);

% 将刹车标志列添加到v1的新一列
v3_with_braking = [v3, is_braking];
%%
clear i
v4 = data4(:, 5);
a4 = data4(:, 8);
% 初始化计数器和刹车标志列
brake_counter = 0;
is_braking = zeros(size(v4));  % 新的列，默认为0

for i = 2:length(v1)-1
    if (v4(i)>v4(i-1) || a3(i) < 0)&&(v4(i)<v4(i-1) || a4(i)>0)
        brake_counter = brake_counter + 1;
        is_braking(i) = 1;  % 将对应位置的刹车标志设置为1
    end
end

% 打印刹车次数
fprintf('刹车次数：%d\n', brake_counter);

% 将刹车标志列添加到v1的新一列
v4_with_braking = [v4, is_braking];