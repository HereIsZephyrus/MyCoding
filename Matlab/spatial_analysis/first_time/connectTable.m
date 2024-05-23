clc;clear;close all;
load rawData.mat

correctInd = find(cityName1 == "常徳市");
cityName1(correctInd) = "常德市";
correctInd = find(cityName1 == "深河市");
cityName1(correctInd) = "漯河市";
correctInd = find(cityName1 == "常徳市");
cityName1(correctInd) = "常德市";
correctInd = find(cityName1 == "脩州市");
cityName1(correctInd) = "儋州市";
correctInd = find(cityName1 == "荷泽市");
cityName1(correctInd) = "菏泽市";
correctInd = find(cityName1 == "莱芜市");
cityName1(correctInd) = "莱芜省";
correctInd = find(cityName1 == "那曲冇");
cityName1(correctInd) = "那曲市";
correctInd = find(cityName1 == "麥庄市");
cityName1(correctInd) = "枣庄市";
clear correctInd

cityWater = sortrows(cityWater,'cityName');
provinceInd = intersect(find(~[endsWith(cityName1,"省")]),find(~[endsWith(cityName1,"区")]));

cityName1 = cityName1(provinceInd);
waterSupply = waterSupply(provinceInd);
totalWaterResources = totalWaterResources(provinceInd);
hostPop = hostPop(provinceInd);
stayPop = stayPop(provinceInd);
ConsummerSupply = ConsummerSupply(provinceInd);

[cityName1, index] = sort(cityName1);
waterSupply = waterSupply(index);
totalWaterResources = totalWaterResources(index);
hostPop = hostPop(index);
stayPop = stayPop(index);
ConsummerSupply = ConsummerSupply(index);

for i = 1 : length(cityWater.provinceID)
    if (cityWater(i,:).cityName ~= cityName1(i))
        cityName1 = [cityName1(1:i-1);"";cityName1(i:end)];
        waterSupply = [waterSupply(1:i-1);NaN;waterSupply(i:end)];
        totalWaterResources = [totalWaterResources(1:i-1);NaN;totalWaterResources(i:end)];
        hostPop = [hostPop(1:i-1);NaN;hostPop(i:end)];
        stayPop = [stayPop(1:i-1);NaN;stayPop(i:end)];
        ConsummerSupply = [ConsummerSupply(1:i-1);NaN;ConsummerSupply(i:end)];
    end
end

staticTable = table(waterSupply,totalWaterResources,hostPop,stayPop,ConsummerSupply);
data = [cityWater staticTable];
data = sortrows(data,'cityID');

save data.mat data
writetable(data,"data.csv");