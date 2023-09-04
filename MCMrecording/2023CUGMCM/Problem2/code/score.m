% 设置一些初始环境，清空命令窗口，关闭图窗，清空工作区变量
clc;
close all;
clear;

% 定义订单需求和盒子组合
order = [7, 4]; % 需要的订单数量
N1 = [3, 2];   % 第一种盒子能装载的货物组合
N2 = [2, 1];   % 第二种盒子能装载的货物组合
N3 = [2, 1];   % 第三种盒子能装载的货物组合
N4 = [6, 3];   % 第四种盒子能装载的货物组合
N5 = [6, 4];   % 第五种盒子能装载的货物组合
Res = {N1; N2; N3; N4; N5}; % 将盒子组合存储到单元格数组中

% 准备一个空数组，用于存储不同的盒子数量组合
countdata = [];

% 调用递归函数生成所有满足条件的盒子数量组合
generateCombinations(order, zeros(1, length(Res)), 1);

% % 显示生成的盒子数量组合
% disp(countdata);

% 递归函数，生成所有满足条件的盒子数量组合
function generateCombinations(remainingOrder, currentCombination, boxIndex)
    if boxIndex > length(Res)
        return; % 递归结束条件，当所有盒子都被考虑过时，结束递归
    end
    
    currentBox = Res{boxIndex}; % 获取当前盒子的能力
    maxBoxes = min(floor(remainingOrder ./ currentBox), currentCombination + 1); % 计算当前盒子的最大数量
    
    % 遍历当前盒子的数量情况，从最大数量到0
    for numBoxes = maxBoxes(1):-1:0
        updatedCombination = currentCombination;
        updatedCombination(boxIndex) = numBoxes;
        
        remainingOrderAfterCurrentBox = remainingOrder - numBoxes * currentBox; % 计算考虑了当前盒子后剩余的订单
        
        % 判断是否满足条件，如果剩余订单都被满足，则将当前盒子数量组合添加到结果中
        if sum(remainingOrderAfterCurrentBox > 0) == 0
            countdata = [countdata; updatedCombination];
        else
            % 如果剩余订单没有被满足，则递归调用下一个盒子
            generateCombinations(remainingOrderAfterCurrentBox, updatedCombination, boxIndex + 1);
        end
    end
end
