clc;close all;clear
% 读取数据
data = readtable('E:\1数学建模2023\2023国赛（）\第二次培训\解决算法\1号单装载.xlsx');
box = xlsread('E:\1数学建模2023\2023国赛（）\第二次培训\数据预处理\原始数据\箱子数据.xlsx');
orderdata=xlsread('E:\1数学建模2023\2023国赛（）\第二次培训\数据预处理\原始数据\订单数据.xlsx');
%%
% 输入检索订单号
n = 1; % 你可以将 n 设置为你想要检索的订单号
% 在订单数据中检索订单号为 n 的行
indices = orderdata(:, 1) == n;
order_items = orderdata(indices, :);

% 从订单数据中获取最后一列数据
p = order_items(:, end)';
A  =box(:,3);
B = box (:,4);
C=  box(:,5);
quantity = zeros(1, length(p)); % 初始物体数量向量
Obj=data;

%% 求解最优方案
num=1;%订单总数
for i=1:num
    for cate=1:5
        Res{i,cate}=CalcSolution(p,A(cate),B(cate),C(cate),Obj(:,:),quantity);
    end
end
clear i

% Res=cell(num,5);%装箱方案计算