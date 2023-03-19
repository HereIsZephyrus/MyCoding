% Floyd-Warshall algorithm implementation for multi-source shortest path problems
function [shortest_paths] = Floyd(adj_matrix)
    % Get the number of nodes
    num_nodes = size(adj_matrix, 1);
    % Initialize the shortest paths matrix with the adjacency matrix
    shortest_paths = adj_matrix;
    % Set the diagonal elements to 0
    for i = 1:num_nodes
        shortest_paths(i, i) = 0;
    end

    % Floyd-Warshall algorithm
    for k = 1:num_nodes
        for i = 1:num_nodes
            for j = 1:num_nodes
                % Update the shortest path between nodes i and j
                shortest_paths(i, j) = min(shortest_paths(i, j), shortest_paths(i, k) + shortest_paths(k, j));
            end
        end
    end
end
