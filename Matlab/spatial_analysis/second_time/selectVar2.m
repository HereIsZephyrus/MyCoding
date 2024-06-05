clc;clear;close all;
load s1data.mat
name = data.name;
eName = data.eName;
code = data.code;
pm = data.pm;
GRP = data.Finance.GRP;
GRPgrowth = data.Finance.GRPgrowth;
primaryGDPRate = data.Finance.primaryGDPRate;
secondaryGDPRate = data.Finance.secondaryGDPRate;
teriaryGDPRate = data.Finance.teriaryGDPRate;

primaryPopulation = data.Industry.primaryPopulation;
manufacturingPopulation = data.Industry.manufacturingPopulation;
distributionPopulation = data.Industry.distributionPopulation;
constructionPopulation = data.Industry.constructionPopulation;
servicesPopulation = data.Industry.servicesPopulation;
otherPopulation = data.Industry.otherPopulation;

household = data.Population.household;
growthRate = data.Population.growthRate;
employed = data.Population.employed;
secondaryIndustry = data.Population.secondaryIndustry;

busPassenger = data.Transportation.busPassenger;
highwayPassenger = data.Transportation.highwayPassenger;
aviationPassenger = data.Transportation.aviationPassenger;

birth = data.Urban.birth;
builtupArea = data.Urban.builtupArea;
landArea = data.Urban.landArea;
greenRate = data.Urban.greenRate;
electricityTotal = data.Urban.electricityTotal;
electricityIndustrial = data.Urban.electricityIndustrial;
gasSupply = data.Urban.gasSupply;

data = table(name,eName,code,pm, ...
    GRPgrowth,primaryGDPRate,secondaryGDPRate,teriaryGDPRate, ...
    primaryPopulation,manufacturingPopulation,servicesPopulation, ...
    household,growthRate,employed,secondaryIndustry, ...
    busPassenger,highwayPassenger,aviationPassenger, ...
    birth,builtupArea,landArea,greenRate,electricityTotal,gasSupply);

tName = fieldnames(data);
tName = tName(5:end-3);
map = addcolorplus(286);
[r,p] = corrcoef(table2array(data(:,5:end)));
heatmap(tName,tName,r,"Colormap",map,"Title","筛选后变量相关系数热图");
save s2data.mat data