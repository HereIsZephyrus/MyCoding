% Define objective function
f = @(x) (4*x(1) + 6*x(2) - 2*x(1)^2 - 2*x(1)*x(2) - 2*x(2)^2);

% Set initial guess and tolerance
x0 = [4; 0];
tol = 1e-6;

% Use steepest descent algorithm to find maximum
[x, fval] = steepest_descent(f, x0, tol);

% Print results
disp(['Maximum value: ', num2str(-fval)]);
disp(['Maximum point: (', num2str(x(1)), ', ', num2str(x(2)), ')']);
function [x, fval] = steepest_descent(f, x0, tol)
% Steepest descent algorithm for maximizing a function
% f: function handle of objective function
% x0: initial guess
% tol: tolerance for convergence
% x: solution
% fval: objective function value at x

% Set parameters
c1 = 0.1;     % Armijo-Goldstein parameter
alpha = 1;    % initial step size

% Initialize
x = x0;
[fval, grad] = f(x);
iter = 0;

% Iteration
while norm(grad) > tol
    d = -grad;     % search direction
    while f(x + alpha*d) > fval + c1*alpha*(grad'*d)
        alpha = alpha/2;    % backtracking line search
    end
    x = x + alpha*d;    % update solution
    [fval, grad] = f(x);  % evaluate new point
    iter = iter + 1;
end

end


