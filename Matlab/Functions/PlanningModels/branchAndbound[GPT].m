% Branch and Bound Algorithm Template for Integer Programming Problems in MATLAB

function [optimal_solution, optimal_value] = branchAndbound(A, b, c)
    % Input: A, b, c are the matrices representing the integer programming problem
    % Output: optimal_solution is the optimal integer solution, optimal_value is the optimal objective value

    % Initialize the problem
    problem = struct('A', A, 'b', b, 'c', c, 'lb', [], 'ub', []);
    [optimal_solution, optimal_value] = branch_and_bound_recursive(problem, -inf, []);
end

function [optimal_solution, optimal_value] = branch_and_bound_recursive(problem, best_value, best_solution)
    % Solve the linear relaxation of the problem
    [solution, value] = linprog(-problem.c, problem.A, problem.b, [], [], problem.lb, problem.ub);

    % Check if the solution is integer
    if all(round(solution) == solution)
        if value > best_value
            optimal_solution = solution;
            optimal_value = value;
        else
            optimal_solution = best_solution;
            optimal_value = best_value;
        end
        return;
    end

    % Branch on the first non-integer variable
    non_integer_var = find(round(solution) ~= solution, 1);
    non_integer_val = solution(non_integer_var);

    % Create left and right subproblems
    left_problem = problem;
    left_problem.ub = [problem.ub; floor(non_integer_val)];
    right_problem = problem;
    right_problem.lb = [problem.lb; ceil(non_integer_val)];

    % Solve left and right subproblems recursively
    [left_solution, left_value] = branch_and_bound_recursive(left_problem, best_value, best_solution);
    [right_solution, right_value] = branch_and_bound_recursive(right_problem, best_value, best_solution);

    % Choose the best solution from left and right subproblems
    if left_value > right_value
        optimal_solution = left_solution;
        optimal_value = left_value;
    else
        optimal_solution = right_solution;
        optimal_value = right_value;
    end
end