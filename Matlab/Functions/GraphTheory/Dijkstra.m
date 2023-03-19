function Distance=Dijkstra(Started,adjMatrix)
%邻接矩阵记录的单源最短路径
numNodes = size(adjMatrix, 1);
% Initialize the distance array and visited array
Distance = inf(1, numNodes);
Distance(Started) = 0;
visited = false(1, numNodes);

for i = 1:numNodes
    % Find the node with the minimum distance that has not been visited
    [~, current_node] = min(Distance .* (~visited));
    % Mark the current node as visited
    visited(current_node) = true;
    % Update the distances of the neighboring nodes
    for neighbor = 1:numNodes
        if adjMatrix(current_node, neighbor) > 0 && ~visited(neighbor)
            new_distance = Distance(current_node) + adjMatrix(current_node, neighbor);
            if new_distance < Distance(neighbor)
                Distance(neighbor) = new_distance;
            end
        end
    end
end
end

% Define the adjacency matrix for the graph

% Define the number of nodes in the graph