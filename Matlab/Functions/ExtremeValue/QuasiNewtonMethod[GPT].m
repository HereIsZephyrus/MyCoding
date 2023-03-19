% Quasi-Newton Method Template for Nonlinear Programming Problems in MATLAB

function [optimal_solution, optimal_value] = QuasiNewtonMethod(f, grad_f, x0, tol, max_iter)
    % Input: f is the objective function, grad_f is the gradient of f
    %        x0 is the initial point, tol is the tolerance, max_iter is the maximum number of iterations
    % Output: optimal_solution is the optimal solution, optimal_value is the optimal objective value

    % Initialize the algorithm
    x = x0;
    iter = 0;
    B = eye(length(x0)); % Initial approximation of the Hessian inverse

    % Main loop
    while iter < max_iter
        % Compute the gradient at the current point
        g = grad_f(x);

        % Check for convergence
        if norm(g) < tol
            break;
        end

        % Compute the search direction
        p = -B * g;

        % Perform a line search to find the optimal step size
        alpha = line_search(f, x, p);

        % Update the solution
        x_new = x + alpha * p;

        % Update the Hessian inverse approximation
        s = x_new - x;
        y = grad_f(x_new) - g;
        B = B + (y * y') / (y' * s) - (B * s * s' * B) / (s' * B * s);

        % Update the current point
        x = x_new;

        % Increment the iteration counter
        iter = iter + 1;
    end

    % Return the optimal solution and value
    optimal_solution = x;
    optimal_value = f(x);
end

function alpha = line_search(f, x, p)
    % Input: f is the objective function, x is the current point, p is the search direction
    % Output: alpha is the optimal step size

    % Initialize the line search parameters
    alpha = 1;
    c1 = 1e-4;
    rho = 0.5;

    % Perform the line search
    while f(x + alpha * p) > f(x) + c1 * alpha * grad_f(x)' * p
        alpha = rho * alpha;
    end
end