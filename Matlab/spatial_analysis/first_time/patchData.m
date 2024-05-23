clc;clear;close all;
load data.mat
load neighbor-data.mat
for i = 1 : length(toAbandon)
    cities = find(data.provinceID == provinces(toAbandon(i)));
    data(cities,:) = [];
end
clear i cities

len = length(data.cityName);
deleteInd = 0;
deleteCities = [];
for i = 1 : len
    if (data.hostPop(i) == -1 || data.stayPop(i) == -1)
        deleteInd = deleteInd + 1;
        deleteCities(deleteInd) = i;
        continue;
    end
    if (data.supply(i) == -1)
        if (data.neighbors(i) == "") 
            deleteInd = deleteInd + 1;
            deleteCities(deleteInd) = i;
            continue;
        end
        neighbor = split(data.neighbors(i),',');
        count = 0;
        value = 0;
        for j = 1 : length(neighbor)
            orient = find(data.cityID == str2num(neighbor(j)));
            if (data.supply(orient) ~= -1)
                count = count + 1;
                value = value + data.supply(orient);
            end
        end
        if (count == 0)
            deleteInd = deleteInd + 1;
            deleteCities(deleteInd) = i;
            continue;
        end
        data.supply(i) = round(value / count);
    end
    clear count value


    if (data.consummerSupply(i) == -1)
        if (data.neighbors(i) == "") 
            deleteInd = deleteInd + 1;
            deleteCities(deleteInd) = i;
            continue;
        end
        neighbor = split(data.neighbors(i),',');
        count = 0;
        value = 0;
        for j = 1 : length(neighbor)
            orient = find(data.cityID == str2num(neighbor(j)));
            if (data.consummerSupply(orient) ~= -1)
                count = count + 1;
                value = value + data.consummerSupply(orient);
            end
        end
        if (count == 0)
            deleteInd = deleteInd + 1;
            deleteCities(deleteInd) = i;
            continue;
        end
        data.supply(i) = round(value / count);
    end
    clear count value

    if (data.resource(i) == -1)
        if (data.neighbors(i) == "") 
            deleteInd = deleteInd + 1;
            deleteCities(deleteInd) = i;
            continue;
        end
        neighbor = split(data.neighbors(i),',');
        count = 0;
        value = 0;
        for j = 1 : length(neighbor)
            orient = find(data.cityID == str2num(neighbor(j)));
            if (data.resource(orient) ~= -1)
                count = count + 1;
                value = value + data.resource(orient);
            end
        end
        if (count == 0)
            deleteInd = deleteInd + 1;
            deleteCities(deleteInd) = i;
            continue;
        end
        data.resource(i) = round(value / count);
    end
    clear count value
end
clear i

data(deleteCities,:) = [];
save cleaned-data.mat data