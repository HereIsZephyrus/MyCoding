clc;close all;clear

loaded_data = load('roadmapshpdata.mat');
Roadmap = loaded_data.shapefileData;


%%
boundingbox = {Roadmap.BoundingBox}';
xCoords = {Roadmap.X}';
yCoords = {Roadmap.Y}';

%%
% 指定筛选条件的经纬度范围
lonMin = -37.5;
lonMax = -37.06;
latMin = -10.90316197;
latMax = -10.90;

% 初始化空的 cell 数组，用于存储符合条件的数据
filteredData = {};

% 遍历所有的道路范围
for i = 1:length(boundingbox)
    % 获取当前道路范围的最大和最小经纬度
    minLon = boundingbox{i}(1);
    minLat = boundingbox{i}(2);
    maxLon = boundingbox{i}(3);
    maxLat = boundingbox{i}(4);
    
    % 对于 lon（经度） 的情况
    lonCondition = (maxLon > lonMin && minLon < lonMax) || ...
                   (maxLon < lonMax && minLon > lonMin) || ...
                   (maxLon > lonMin && minLon < lonMax);
    
    % 对于 lat（纬度） 的情况
    latCondition = (maxLat > latMin && minLat < latMax) || ...
                   (maxLat < latMax && minLat > latMin) || ...
                   (maxLat > latMin && minLat < latMax);
    
    % 根据逻辑进行筛选
    if lonCondition && latCondition
        % 当前数据满足条件，将其记录到筛选结果中
        filteredData{end+1} = struct(...
            'BoundingBox', boundingbox{i}, ...
            'X', xCoords{i}, ...
            'Y', yCoords{i} ...
        );
    end
end

% 现在 filteredData 包含了满足条件的数据，包括范围、X 和 Y 坐标
%%
filteredData=filteredData';
%%
% save('Need1_roadBoundingBoxed_data.mat', 'filteredData');
% 现在 filteredBoundingBoxes 包含了满足条件的道路范围数据
