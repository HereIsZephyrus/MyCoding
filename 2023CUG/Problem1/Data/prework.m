clc;clear;close all;
load rawData.mat
%% 预处理
scoreAge=zeros(len,1);
scoreTime=zeros(len,1);
for i=1:len
    scoreAge(i)=CalcMatherAge(cateData.motherAge(i));
    scoreTime(i)=CalcPregTime(cateData.Time(i));
    if (cateData.Method(i)==1)
        cateData.Method(i)=1;
    else
        cateData.Method(i)=-1;
    end
    if (cateData.Sex(i)==1)
        cateData.Sex(i)=-1;
    else
        cateData.Sex(i)=1;
    end
    if (cateData.Marriage(i)==1)
        cateData.Marriage(i)=-1;
    else
        cateData.Marriage(i)=1;
    end
    cateData.CBTS=30-cateData.CBTS;
    cateData.EPDS=30-cateData.EPDS;
    cateData.HADS=30-cateData.HADS;
end
clear i
cateData.motherAge=scoreAge;
cateData.Time=scoreTime;

len2=length(preData.ID);
scoreAge=zeros(len2,1);
scoreTime=zeros(len2,1);
for i=1:len2
    scoreAge(i)=CalcMatherAge(preData.motherAge(i));
    scoreTime(i)=CalcPregTime(preData.Time(i));
    if (preData.Method(i)==1)
        preData.Method(i)=1;
    else
        preData.Method(i)=-1;
    end
    if (preData.Sex(i)==1)
        preData.Sex(i)=-1;
    else
        preData.Sex(i)=1;
    end
    if (preData.Marriage(i)==1)
        preData.Marriage(i)=-1;
    else
        preData.Marriage(i)=1;
    end
end
clear i
preData.motherAge=scoreAge;
preData.Time=scoreTime;
clear scoreTime scoreAge len2
%% 标准化
cateData.motherAge=zscore(cateData.motherAge);
cateData.Time=zscore(cateData.Time);
cateData.Education=zscore(cateData.Education);
cateData.CBTS=zscore(cateData.CBTS);
cateData.EPDS=zscore(cateData.CBTS);
cateData.HADS=zscore(cateData.HADS);
cateData.Sleeping=zscore(cateData.Sleeping);
writetable(cateData,'scoreData.xlsx');
save scoreData.mat