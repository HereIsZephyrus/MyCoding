%failing
function [x_opt, f_opt, iter] = Ontable_operation(A, b, c)
% 实现线性规划的单纯形法
% 输入参数：
% A：约束条件系数矩阵
% b：约束条件右侧值向量
% c：目标函数系数向量
% 输出参数：
% x_opt：最优解
% f_opt：最优目标函数值
% iter：迭代次数

% 初始化单纯形表
[m, n] = size(A);
B = eye(m); % 初始化基矩阵
N = zeros(m, n-m); % 初始化非基矩阵
c = [c; zeros(m+1, 1)]; % 将目标函数系数矩阵扩展为 n 维
T = [A,B, b;c']; % 拼接基矩阵和非基矩阵
iter = 0;

while true
    disp(T);
    pause
    iter = iter + 1;
    % 检查是否已达到最优解
     [~, j] = max(c);
    if c(j) <= 0 % 所有系数都小于等于 0，说明达到最优解
        x_opt = T(1:n-m, n+1);
        f_opt = -T(m+1, n+1); % 目标函数取相反数
        return;
    end
    disp('AAAA');
    % 选取入基变量
    [~, j] = max(c);
    % 检查是否无界
    if all(T(1:m, j) <= 0)
        x_opt = [];
        f_opt = Inf;
        break;
    end
    disp('BBBB');
    % 选取出基变量
    theta = T(1:m, n+1) ./ T(1:m, j);
    theta(theta <= 0) = Inf;
    [~, i] = min(theta);
    % 更新单纯形表
    T(i, :) = T(i, :) / T(i, j);
    for k = 1:m+1
        if k ~= i
            T(k, :) = T(k, :) - T(k, j) * T(i, :);
        end
    end
    disp('CCCC');
end
end
