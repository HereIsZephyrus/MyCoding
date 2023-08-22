clc; close all; clear;
%只装箱子排列组合
% 读取订单数据
orderData = xlsread('E:\1数学建模2023\2023国赛（）\第二次培训\数据预处理\处理数据\工作簿1.xlsx');

% 读取箱子数据
boxData = xlsread('E:\1数学建模2023\2023国赛（）\第二次培训\数据预处理\原始数据\箱子数据.xlsx');

% 数据预处理
orderDimensions = orderData(:, 2:4); % 提取物品的长宽高数据

% 初始化数据容器
Data1 = []; % 全使用箱子装的物品
allData=[];

%%
% 只装袋子
for i = 1:size(orderData, 1)
    itemDimensions = orderDimensions(i, :);

        % 将订单号拼接到每个排列组合数据中
            % 生成所有可能的长宽高排列
    allCombinations = generateCombinations(itemDimensions);
    orderNumbers = repmat([orderData(i, 1),orderData(i,5)], size(allCombinations, 1), 1);
    combinedData = [orderNumbers, allCombinations];
    
    % 将当前订单的排列组合数据添加到allData中
    allData = [allData; combinedData];
end
%%
% 遍历所有排列组合数据
for i = 1:size(allData, 1)
    orderNumber = allData(i, 1:2); % 提取订单号
    dimensions = allData(i, 3:end); % 提取排列组合的长宽高
    canUseBox = false;

    % 遍历袋子数据，检查是否可以使用箱子装
    for k = 1:size(boxData, 1)
        boxDimensions = boxData(k, 3:5);
        if all(dimensions <= boxDimensions)
           canUseBox = true;
           dimensions(:,4)=boxData(k,1);
           dimensions(:,5:7)=boxData(k,3:5);
            break;
        end
    end
 
    % 判断是否需要进行存储
    if canUseBox 
        % 将订单号和排列组合的长宽高存储到Data1中
        combinedData = [orderNumber, dimensions];
        Data1 = [Data1;combinedData];
    end
   
end 
%%

% % 获取唯一的订单号
% order_numbers = unique(Data1(:, 1));
% 
% % 指定保存文件夹路径
% output_folder = 'E:\1数学建模2023\2023国赛（）\第二次培训\数据预处理\处理数据\所有订单箱子数据';
% 
% % 遍历订单号，保存数据
% for i = 1:length(order_numbers)
%     order_number = order_numbers(i);
%     order_data = Data1(Data1(:, 1) == order_number, :);
%     
%     output_filename = fullfile(output_folder, sprintf('%d.csv', order_number));
%     dlmwrite(output_filename, order_data, '\t');
% end

% 排列组合函数，用于生成所有可能的长宽高排列
function combinations = generateCombinations(dimensions)
    combinations = perms(dimensions);
    combinations = unique(combinations, 'rows');
end
