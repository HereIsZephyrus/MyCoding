clc;clear;close all;
load rawData.mat
quality=cell(5,2);
meanSex=zeros(5,1);
singleSleep=zeros(len,1);
effSleep=zeros(len,1);
scoreSleep=zeros(len,1);
cost_awake=[0.7,0.6167,0.4];
con_asleep=[0,1,1,1.5,2];
for i=1:5
    ind=find(cateData.Asleep==i);
    quality{i,1}=cateData(ind,:).Sleeping;
    quality{i,2}=cateData(ind,:).Awake;
    meanSex(i)=mean(cateData(ind,:).Sex);
end
clear i ind
for i=1:len
    singleSleep(i)=cateData.Sleeping(i)/(cateData.Awake(i)+1);
    effSleep(i)=1-cateData.Awake(i)*cost_awake(cateData.babyAge(i))/cateData.Sleeping(i);
    scoreSleep(i)=singleSleep(i)*effSleep(i)+con_asleep(cateData.Asleep(i));
end
clear i
save sleepData.mat quality singleSleep effSleep scoreSleep
