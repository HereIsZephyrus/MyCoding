function [miniumSpantree, Weight] = Kruskal(adjMatrix)
    % Function to implement Kruskal's algorithm for finding the minimum spanning tree
    %计算以邻接矩阵存储的最小生成树,miniumSpantree为最小生成树的形态,Weight为路径长
    % Find the number of nodes in the graph
    num_Nodes = size(adjMatrix, 1);

    % Initialize the minimum spanning tree and total weight
    miniumSpantree = zeros(num_Nodes, num_Nodes);
    Weight = 0;

    % Create a list of edges and sort them by weight
    % 将邻接矩阵按边分解后按长度排序升序排序
    Edge = [];
    for i = 1:num_Nodes
        for j = i+1:num_Nodes
            if adjMatrix(i, j) ~= 0
                Edge = [Edge; i, j, adjMatrix(i, j)];
            end
        end
    end
    Edge = sortrows(Edge, 3);

    % Initialize the disjoint set data structure
    %初始化并查集,将每个节点的父亲节点设置为自己
    Father = 1:num_Nodes;

    % Iterate through the sorted edges
    for i = 1:size(Edge, 1)
        % Find the root of the two nodes in the current edge
        %求出各自祖先
        root1 = find_root(Father, Edge(i, 1));
        root2 = find_root(Father, Edge(i, 2));
        % If the roots are different, add the edge to the minimum spanning tree
        %若不为公共祖先则合并子树\路径长\祖先
        if root1 ~= root2
            miniumSpantree(Edge(i, 1), Edge(i, 2)) = Edge(i, 3);
            miniumSpantree(Edge(i, 2), Edge(i, 1)) = Edge(i, 3);
            Weight = Weight + Edge(i, 3);
            % Merge the two sets
            Father(root2) = root1;
        end
    end
end

% Helper function to find the root of a node in the disjoint set data structure
% 寻找祖先
function root = find_root(father, node)
    while father(node) ~= node
        node = father(node);
    end
    root = node;
end