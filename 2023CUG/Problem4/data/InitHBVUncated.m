clc;clear;close all;
load HBVUncatedData.mat
varnum=size(HBVData,2);
for i=1:varnum
    tmp=table2array(HBVData(:,i));
    indNan=find(isnan(tmp));
    HBVData(indNan,i)=array2table(mean(rmmissing(tmp)));
end
clear i tmp varnum indNan
save HBVCatedData.mat