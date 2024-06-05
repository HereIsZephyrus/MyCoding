clc;clear;close all;
load data.mat
Population = data.Population;
Population = removevars(Population,'RD');
data.Population = Population;

Finance = data.Finance;
Finance = removevars(Finance,'residentialBuilding');
data.Finance = Finance;
%% delete
data = removevars(data,"Discharged");

Industry = data.Industry;
miningPopulation = Industry.MiningPopulation;
nanInd = find(isnan(miningPopulation));
miningPopulation(nanInd) = zeros(length(nanInd),1);
Industry = removevars(Industry,'MiningPopulation');
Industry = addvars(Industry,miningPopulation);
data.Industry = Industry;
%% fill zero
Transportation = data.Transportation;
waterwayPassenger = Transportation.WaterwayPassenger;
aviationPassenger = Transportation.aviationPassenger;
waterwayFreight = Transportation.waterwayFreight;
aviationFreight = Transportation.aviationFreight;
Transportation = removevars(Transportation,'WaterwayPassenger');
Transportation = removevars(Transportation,'aviationPassenger');
Transportation = removevars(Transportation,'waterwayFreight');
Transportation = removevars(Transportation,'aviationFreight');

nanInd = find(isnan(waterwayPassenger));
waterwayPassenger(nanInd) = zeros(length(nanInd),1);
nanInd = find(isnan(aviationPassenger));
aviationPassenger(nanInd) = zeros(length(nanInd),1);

nanInd = find(isnan(waterwayFreight));
waterwayFreight(nanInd) = zeros(length(nanInd),1);
nanInd = find(isnan(aviationFreight));
aviationFreight(nanInd) = zeros(length(nanInd),1);
Transportation = addvars(Transportation,waterwayPassenger,aviationPassenger,waterwayFreight,aviationFreight);
data.Transportation = Transportation;
%% fill average and normalize
for ind = 5:9
    t = data{:,ind};
    [len,varNum] = size(t);
    for var = 1:varNum
        col = table2array(t(:,var));
        nanInd = find(isnan(col));
        aver = mean(col(~isnan(col)));
        col(nanInd) = aver;
        %col = normalize(col,"range");
        t{:,var} = col;
    end
    data{:,ind} = t;
end
%% save data
save s1data.mat data