%% load data and correct the name
clc;clear;close all;
load rawData.mat
Finance = sortrows(Finance,'name');
name = Finance.name;eName = Finance.eName;
nonprovinceInd = intersect(find(~[endsWith(name,"省")]),find(~[endsWith(name,"区")]));
name = name(nonprovinceInd); eName = eName(nonprovinceInd);
Finance = Finance(nonprovinceInd,:);
correctInd = find(name == "常徳市");
name(correctInd) = "常德市";
correctInd = find(name == "深河市");
name(correctInd) = "漯河市";
correctInd = find(name == "常徳市");
name(correctInd) = "常德市";
correctInd = find(name == "脩州市");
name(correctInd) = "儋州市";
correctInd = find(name == "荷泽市");
name(correctInd) = "菏泽市";
correctInd = find(name == "那曲冇");
name(correctInd) = "那曲市";
correctInd = find(name == "麥庄市");
name(correctInd) = "枣庄市";
clear correctInd
%% vert all calced table
Industry = sortrows(Industry,"name");
Industry = Industry(nonprovinceInd,:);
Population = sortrows(Population,"name");
Population = Population(nonprovinceInd,:);
Transportation = sortrows(Transportation,"name");
Transportation = Transportation(nonprovinceInd,:);
Urban = sortrows(Urban,"name");
Urban = Urban(nonprovinceInd,:);

Finance = removevars(Finance,["name","eName"]);
Industry = removevars(Industry,["name","eName"]);
Population = removevars(Population,["name","eName"]);
Transportation = removevars(Transportation,["name","eName"]);
Urban = removevars(Urban,["name","eName"]);
%% connect table
PM25 = sortrows(PM25,"name");
toReserveRow = [];
for i = 1 : length(name)
    if (length(find(PM25.name == name(i)) ) ~= 0)
        toReserveRow = [toReserveRow,i];
    end
end
clear i
name = name(toReserveRow);
eName = eName(toReserveRow);
Finance = Finance(toReserveRow,:);
Industry = Industry(toReserveRow,:);
Population = Population(toReserveRow,:);
Transportation = Transportation(toReserveRow,:);
Urban = Urban(toReserveRow,:);
code = PM25.code; pm = PM25.data;
%% finetune
Finance = renamevars(Finance,"VarName83","currentAssets");
Industry = renamevars(Industry,"VarName30","concentration");
Industry = removevars(Industry,"VarName116");
Industry = removevars(Industry,"VarName160");
Urban = removevars(Urban,"growthRate");
Discharged = Industry(:,1:12);
Discharged = removevars(Discharged,"selfEmployed");
Discharged = removevars(Discharged,"unemployed");
Discharged = removevars(Discharged,"employed");
Population = removevars(Population,"selfEmployed");
Industry = Industry(:,13:end);
%% write data
data = table(name,eName,code,pm,Finance,Discharged,Industry,Population,Transportation,Urban);
save data.mat data