function [x_optimal_strategy,y_optimal_strategy,x_optimal_value] = Zero_sumGame(A,bias)
    % 输入为A,B的赢得矩阵和为了使赢得矩阵每个元素大于0的偏置
    % 采用线性规划的方法求得方案
    % 输出为A,B所采取的最佳策略和玩家1的取胜形势
    [m, n] = size(A);
    A=A+bias*ones(n);
    [x, x_fval] = linprog(ones(n,1),  -A', -ones(m,1), [],[],zeros(3,1));
    [y, y_fval] = linprog(-ones(n,1),  A ,  ones(m,1), [],[],zeros(3,1));
    x_optimal_strategy = x(1:n)/x_fval;
    y_optimal_strategy = y(1:n)/(-y_fval);
    x_optimal_value = 1/x_fval-bias;
end