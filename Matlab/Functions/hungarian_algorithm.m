function [matching, max_matching] = hungarian_algorithm(adj_matrix)
% adj_matrix: 二分图邻接矩阵，0表示未连接，1表示连接

    % 初始化变量
    [num_rows, num_cols] = size(adj_matrix);
    matching = zeros(num_rows, 1); % 存储匹配的列
    visited = zeros(num_rows, 1); % 存储是否已访问
    max_matching = 0; % 最大匹配数

    % 从每个未匹配的行开始寻找增广路径
    for row = 1:num_rows
        if matching(row) == 0
            visited(:) = 0; % 重置visited数组
            if dfs(row)
                max_matching = max_matching + 1;
            end
        end
    end

    % 使用DFS寻找增广路径
    function found_augmenting_path = dfs(row)
        found_augmenting_path = false;
        visited(row) = 1;
        for col = 1:num_cols
            if adj_matrix(row, col) == 1 && visited(col) == 0
                visited(col) = 1;
                if matching(col) == 0 || dfs(matching(col))
                    matching(col) = row;
                    found_augmenting_path = true;
                    break;
                end
            end
        end
    end
end
