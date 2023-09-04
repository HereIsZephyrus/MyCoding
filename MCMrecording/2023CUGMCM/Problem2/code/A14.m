 %% 一个订单的处理

clc;close all;clear
% 读取订单数据
orderData = readtable('第1号装载数据.csv');
orderData = table2array(orderData);
% 读取箱子数据
boxData = xlsread('箱子数据.xlsx');
%%
% 提取规格和数量信息
uniqueOrders = unique(orderData(:, 1));
results = [];
Quantity=[];
long=[];
wid=[];
hig=[];

% 遍历每个订单
for i = 1:length(uniqueOrders)
    order = uniqueOrders(i);
    orderRows = orderData(orderData(:, 1) == order, :);
    
    % 提取订单数据中规格的数量
    orderQuantities = orderRows(:, 2);
    dimensions = orderRows(:, 3:5);
    tmpL=1;tmpW=1;tmpH=1;%已经记录的长宽高中的最大值
    % 遍历每个规格
    for j = 1:size(orderRows, 1)
        quantity = orderQuantities(j);
        dims = dimensions(j, :);
        V=dims(1) * dims(2) * dims(3);
        length1=dims(1,1);
        width1=dims(1,2);
        high1=dims(1,3);

        for k=1:size(boxData, 1)
        % 计算最大矩形体数量
        boxDims = boxData(k, 3:5);
        V_box= prod(quantity(:,:)*boxData(k,3:5));
        maxlong=floor(boxDims(:,1)/length1);
        maxwidth=floor(boxDims(:,2)/width1);
        maxhigh=floor(boxDims(:,3)/high1);
        for x=tmpL+1:maxlong
            for y=tmpW:maxwidth
                for z=tmpH:maxhigh
                    long=[long;x];wid=[wid;y];hig=[hig;z];c = ([x, y, z]);
                end
            end
        end
        for y=tmpW+1:maxwidth
            for z=tmpH:maxhigh
              long=[long;x];wid=[wid;y];hig=[hig;z];c = ([tmpL, y, z]);
            end
        end
        for z=tmpH+1:maxhigh
          long=[long;x];wid=[wid;y];hig=[hig;z];c = ([tmpL, tmpW, z]);
        end
        tmpL=max(tmpL,maxlong);tmpW=max(tmpW,maxwidth);tmpH=max(tmpH,maxhigh);
        %long=[long;maxlong];
        %wid=[wid;maxwidth];
        %hig=[hig;maxhigh];
        %c = ([long, wid, hig]);
%         Quantity = [Quantity;maxQuantity];
%        if maxQuantity > orderQuantities
%            
%           
%         end
        end


        
    end
end


%%
h = j;  % 替换为您的需求，指示要分割的批次数量
batchSize = size(maxQuantity, 1) / h;  % 计算每个批次的大小


for i = 1:h
    startIndex = (i - 1) * batchSize + 1;  % 计算起始索引
    endIndex = i * batchSize;  % 计算结束索引
    
    variableName = ['data' num2str(i)];  % 构造变量名
    dataStruct.(variableName) = maxQuantity(startIndex:endIndex, :);  % 将数据赋值给相应变量
end
%%
% 初始化记录的变量
recordedData = [];
fields = fieldnames(dataStruct);
% 遍历每个 h 和 p 组合
for i = 1:length(fields)
    h = str2double(fields{i}(end));  % 提取 h 值
    datah = dataStruct.(fields{i});
    
    for p = 1:size(datah, 1)
        rowValues = datah(p, :);
        
        % 检查行数据是否全部非零
        if all(rowValues ~= 0)
            recordedData = [recordedData; h, p, rowValues];
        end
    end
end

% 根据 recordedData 中的 h 和 p 值检索相关数据
newData = [];
for i = 1:size(recordedData, 1)
    hValue = recordedData(i, 1);
    pValue = recordedData(i, 2);

    orderDataValues = orderData(hValue, 1:5);
    boxDataValues = boxData(pValue, 3:5);
    newData = [newData; orderDataValues, boxDataValues, recordedData(i, 3:end)];
end
%%

% 计算并添加新的列数据到 newData 中

l1= newData(:,9);%长的个数
l2=newData(:,10);%宽的个数
l3=newData(:,11);%高的个数
numl123=l1 .* l2 .* l3;
newData(:,12)=numl123; %一个箱子中一共能摆放的数量
for i = 1: size(newData,1)
    if newData(i,12) >= newData(i,2)
       newData(i,13) = newData(i,2); %实际用的箱子装载的个数
    else 
        newData(i,13) =newData(i,12);
    end
end

newData(:, 14) = newData(:, 6) .* newData(:, 7) .* newData(:, 8) ;%箱子单个体积
newData(:, 15) = newData(:, 3) .* newData(:, 4) .* newData(:, 5) .* newData(:,13) ;%货物实际总体积
newData(:, 16) = ceil(newData(:, 13) .\ newData(:, 2));  % 箱子数量，向上取整，如果有余数则加 1
newData(:, 17) = newData(:, 14) .* newData(:,16) ;%使用箱子总体积
newData(:,18) = 1-(newData(:,17) .\ newData(:,15))+newData(:,16); %得分 = 1-（实际装载的总体积/使用箱子的总体积）+箱子个数
% newData(:, end) = newData(:, 9) .* newData(:, 3) .* newData(:, 10) .* newData(:, 4) .* newData(:, 11) .* newData(:, 5);
%%
% 将 newData 按照第 12 列数据从大到小排序
sortedData = sortrows(newData, -12);

% 将排序后的数据保存为 needdata
needdata = sortedData;

%%
% 计算第二到第四列的和作为特征
feature_sums = sum(needdata(:, 3:5), 2);
%%
% 初始化一个列向量，用于存储类别信息
categories = zeros(size(needdata, 1), 1);

% 根据特征和计算类别
unique_sums = unique(feature_sums);
numCategories = numel(unique_sums);

for i = 1:numCategories
    matchingRows = feature_sums == unique_sums(i);
    categories(matchingRows) = i;
end



% 将类别信息添加到原数据中
data_with_categories = [needdata, categories];
OOdata=[needdata(:,15),needdata(:,9),needdata(:,10),needdata(:,11),needdata(:,3),needdata(:,4),needdata(:,5),data_with_categories(:,end)];
%%
% %表头
% 假设您已经准备好名为 'data2_updated' 的数据矩阵

% 假设您已经准备好名为 'data2_updated' 的数据矩阵

% 创建一个假定的表头
header = {'体积Volume','numL','nunmW','numH','L','W','H','cate'}; % 根据实际列数添加标题

% 将表头和数据组合成一个矩阵
combinedData = [header; num2cell(OOdata)]; % 注意使用 num2cell 将数据矩阵转换为单元格数组


% 设置写入文件的路径
output_path = 'E:\1数学建模2023\2023国赛（）\第二次培训\数据预处理\处理数据\1号单装载.xlsx';

% % 使用 xlswrite 将整个矩阵写入 Excel 文件
% xlswrite(output_path, combinedData);

disp('数据已更新并写入新文件。');

