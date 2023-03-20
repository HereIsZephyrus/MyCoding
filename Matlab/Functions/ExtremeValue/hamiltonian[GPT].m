% Hamiltonian function for dynamic optimization model problems
function H = hamiltonian(x, u, lambda)
    % Define the system dynamics
    f = [x(2); -x(1) - x(2)^3 + u];
    % Define the cost function
    L = x(1)^2 + x(2)^2 + u^2;
    % Define the Hamiltonian function
    H = L + lambda'*f;
end