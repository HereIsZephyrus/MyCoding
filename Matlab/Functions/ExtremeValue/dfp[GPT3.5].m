function [x, fval] = dfp(fun, x0, tol)
% DFP algorithm for nonlinear programming
% fun: function handle of objective function and constraints
% x0: initial guess
% tol: tolerance for convergence
% x: solution
% fval: objective function value at x
%{
[f, g] = dfp(x)
x是当前点的向量，f是目标函数的值，g是梯度向量。
%}
n = length(x0);   % dimension of problem
H = eye(n);       % initial Hessian approximation
x = x0;
[f, g] = feval(fun, x);
iter = 0;

while norm(g) > tol
    p = -H * g;   % compute search direction
    alpha = backtracking(fun, x, p, g);   % compute step size
    s = alpha * p;
    x = x + s;    % update solution
    [f_new, g_new] = feval(fun, x);        % evaluate new point
    y = g_new - g;                          % compute gradient difference
    H = H + (s * s')/(s' * y) - (H * y * y' * H)/(y' * H * y);   % update Hessian approximation
    f = f_new;
    g = g_new;
    iter = iter + 1;
end

fval = f;   % return objective function value
end

function alpha = backtracking(fun, x, p, g)
% backtracking line search
% fun: function handle of objective function and constraints
% x: current point
% p: search direction
% g: gradient at current point
% alpha: step size

alpha = 1;   % initial step size
c = 0.1;     % backtracking parameter
rho = 0.5;   % backtracking parameter
[f, ~] = feval(fun, x);

while feval(fun, x + alpha * p) > f + c * alpha * g' * p
    alpha = rho * alpha;   % reduce step size
end
end
