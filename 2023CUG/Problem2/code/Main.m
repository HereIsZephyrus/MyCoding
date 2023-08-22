clc;close all;clear
% 读取数据
data = xlsread('E:\1数学建模2023\2023国赛（）\第二次培训\解决算法\1号单装载.xlsx');
box = xlsread('E:\1数学建模2023\2023国赛（）\第二次培训\数据预处理\原始数据\箱子数据.xlsx');
% 根据数据创建合适的结构体或矩阵来存储物体信息
% 例如，可以使用结构体数组来存储物体信息，每个结构体包含 Volume、numL、numW、numH、L、W、H、cate
% p= [ A B C]数组，订单数量
%%
% 设置初始参数，包括订单需求、空间大小等
p = 1; % 当前订单物体数量需求向量
A = 1 ;% 当前空间的三维大小
B = 1;
C = 1;
quantity = zeros(1, length(data)); % 初始物体数量向量

% 调用求解函数
solution = CalcSolution(p, A, B, C, data, quantity);
