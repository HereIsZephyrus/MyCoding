clc;close all;clear

load('Ha059.mat')
load('Ha159.mat')
load("Coordinate_point.mat")
Pointdata = data;
clear data
load('Cargoneedpreday.mat')
Pointdata(:,4) = data(:,2);
clear data
load('Roadconnect.mat')
Roadconnect=Roadconnectrelation(2:end,2:end);
clear Roadconnectrelation;
load("Coordinate_point.mat")
Roadconnect(5,9)=0;
% 数据预处理，保存为 waypoints
waypoints = data;
clear data
% 距离矩阵存储各个点之间的距离
num_points = size(waypoints, 1);
dist_matrix = zeros(num_points, num_points);
for i = 1:num_points
    for j = 1:num_points
        dist_matrix(i, j) = sqrt((waypoints(i, 2) - waypoints(j, 2))^2 + (waypoints(i, 3) - waypoints(j, 3))^2);
    end
end
clear i 
n = size(dist_matrix, 1);

% 根据连通关系矩阵设置初始距离矩阵
for i = 1:n
    for j = 1:n
        if Roadconnect(i, j) == 1
            dist_matrix(i, j) = dist_matrix(i, j);  % 设置为实际距离
        else
            dist_matrix(i, j) = inf;  % 设置为无穷大表示不可达
        end
    end
end
for i=1:n
    dist_matrix(i,i)=0;
end
% Floyd-Warshall算法
for k = 1:n
    for i = 1:n
        for j = 1:n
            if dist_matrix(i, k) + dist_matrix(k, j) < dist_matrix(i, j)
                dist_matrix(i, j) = dist_matrix(i, k) + dist_matrix(k, j);
            end
        end
    end
end
clear i j k n


% data = pointsAboveLine;
% data = pointsBelowLine;
num_iterations = 1000; % 迭代次数
tabu_length = 10;      % 禁忌表长度

remaining_points = setdiff(1:num_points, 5);
%% 迭代
Allbestdistance = [];
best_solution=[];
for m = 1:length(H1(:,1))
    data = H1(m,:);
    nan_indices = isnan(data);
    data(nan_indices) = [];
    randdata = length(data(1,:))-1;
    parfor o = 1 :10  
        idp = data(1,1);
        idx = find(data(1,: ) == idp);
        elements_found = ismember(data,idp);
    
        newdata = data(~elements_found);
        current_solution=[idp,newdata,idp];
    
        L =  length(current_solution(1,:));
        best_solution = current_solution;
        best_distance = calculate_total_distance(dist_matrix, current_solution);
    
    %%
        tabu_list = zeros(1, L);
    
        for iter = 1:num_iterations
            best_neighbor = [];
            best_neighbor_distance = Inf;
            
            for i = 1:L
                for j = i+1:L
                    new_solution = current_solution;
                    new_solution(i) = current_solution(j);
                    new_solution(j) = current_solution(i);
                    
                    if ~ismember(new_solution, tabu_list, 'rows')
                        distance = calculate_total_distance(dist_matrix, new_solution);
                        if distance < best_neighbor_distance
                            best_neighbor_distance = distance;
                            best_neighbor = new_solution;
                        end
                    end
                end
            end
        
            if best_neighbor_distance < best_distance
                current_solution = best_neighbor;
                best_distance = best_neighbor_distance;
                
            if size(tabu_list, 1) >= tabu_length
                tabu_list(1, :) = [];
            end
            tabu_list = [tabu_list; best_neighbor];
            
            if best_distance < calculate_total_distance(dist_matrix, best_solution)
                best_solution = best_neighbor;
            end
        end
    end
    
    % 在最优解中添加起始点并计算总距离
    %best_solution = [best_solution]; % 添加出发点
    best_distance = calculate_total_distance(dist_matrix, best_solution);
    
    disp('最优路径：');
    disp(best_solution);
    disp(['最短总路程：', num2str(best_distance)]);
    bestall_solution(o,1) = best_distance;
    disp('----------')

    end
    disp('下一组哈密顿闭环最短为')
    Allbestdistance(m,1) = min(bestall_solution);
end
%% 自定义计算距离

% 计算路径总距离的函数
function total_distance = calculate_total_distance(dist_matrix, solution)
    total_distance = 0;
    num_points = length(solution);
    for i = 1:num_points-1
        total_distance = total_distance + dist_matrix(solution(i), solution(i+1));
    end
    total_distance = total_distance + dist_matrix(solution(num_points), solution(1)); % 返回起始点
end