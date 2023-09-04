%%
clc;close all;clear

PointHamilton = xlsread('Hamilton.csv');
load("Coordinate_point.mat")

Coordinate_point = data;
clear data

load('Cargoneedpreday.mat')
Coordinate_point(:,4) = data(:,2);
clear data

% 创建新的空数组来存储符合要求的行数据

% valid_rows=[];
H0=[];
% 循环遍历PointHamilton的每一行
for i = 1:size(PointHamilton, 1)
    % 提取出现的站点号（假设PointHamilton的每一行表示一组站点组合）
    current_combination = PointHamilton(i, :);
    
    % 初始化总需求
    total_demand = 0;
    
    % 遍历当前组合中的站点号
    for j = 1:length(current_combination)
        % 提取站点号
        current_point = current_combination(j);
        
        % 使用站点号从Coordinate_point中检索相应的站点需求
        % 假设Coordinate_point的第一列是站点号，第四列是需求
        idx = find(Coordinate_point(:, 1) == current_point);
        
        % 如果找到了站点，累加需求
        if ~isempty(idx)
            total_demand = total_demand + Coordinate_point(idx, 4);
        end
    end
    
    % 检查总需求是否满足条件（大于500且小于246）
 
    disp('排列方式')
    disp(i)
    disp('的总需求为')
    disp(total_demand)
    disp('-----------------')

   if total_demand < 500 && total_demand > 246
        % 将当前行数据存储到valid_rows中
        valid_rows =PointHamilton(i,:) ;
        H0=[H0;valid_rows];
    end


end
clear i j total_demand valid_rows current_point current_combination idx 
%%
% 假设 H0 是一个包含站点排列组合的矩阵，Coordinate_point 是一个包含站点需求的矩阵，第一列是站点号
% 创建一个空的 H1 矩阵来存储未出现的站点号
PointStation = Coordinate_point(:,1)';
H1 = nan(size(H0, 1), 14); % 初始化H1为NaN

for i = 1:size(H0, 1)

current_combination = H0(i, :);
nan_indices = isnan(current_combination);
current_combination(nan_indices) = [];

% 从Coordinate_point的第一列中查找第一行的元素
elements_found = ismember(PointStation,current_combination );

% 创建H1变量来存储不在Coordinate_point中出现的元素
valid_rows = PointStation(~elements_found);
%H1(i) =valid_rows; 
  H1(i, 1:numel(valid_rows)) = valid_rows;
end
clear current_combination nan_indices current_combination i


