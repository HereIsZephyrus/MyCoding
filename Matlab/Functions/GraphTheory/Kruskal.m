% Function to implement Kruskal's algorithm for finding the minimum spanning tree
function [miniumSpantree, total_weight] = Kruskal(adj_matrix)
    % Input: adj_matrix - adjacency matrix representing the graph
    % Output: min_span_tree - minimum spanning tree
    %         total_weight - total weight of the minimum spanning tree

    % Find the number of nodes in the graph
    num_Nodes = size(adj_matrix, 1);

    % Initialize the minimum spanning tree and total weight
    miniumSpantree = zeros(num_Nodes, num_Nodes);
    total_weight = 0;

    % Create a list of edges and sort them by weight
    edges = [];
    for i = 1:num_Nodes
        for j = i+1:num_Nodes
            if adj_matrix(i, j) ~= 0
                edges = [edges; i, j, adj_matrix(i, j)];
            end
        end
    end
    edges = sortrows(edges, 3);

    % Initialize the disjoint set data structure
    parent = 1:num_Nodes;

    % Iterate through the sorted edges
    for i = 1:size(edges, 1)
        % Find the root of the two nodes in the current edge
        root1 = find_root(parent, edges(i, 1));
        root2 = find_root(parent, edges(i, 2));

        % If the roots are different, add the edge to the minimum spanning tree
        if root1 ~= root2
            miniumSpantree(edges(i, 1), edges(i, 2)) = edges(i, 3);
            miniumSpantree(edges(i, 2), edges(i, 1)) = edges(i, 3);
            total_weight = total_weight + edges(i, 3);

            % Merge the two sets
            parent(root2) = root1;
        end
    end
end

% Helper function to find the root of a node in the disjoint set data structure
function root = find_root(parent, node)
    while parent(node) ~= node
        node = parent(node);
    end
    root = node;
end