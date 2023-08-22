clc;clear;close all;
load behaviorRegress.mat
load scoreData.mat
load regressData.mat
load sleepData.mat
load sleepCateData.mat
load cure.mat
coef=coef(6:8,:)';weight=weight';
b=zeros(1,3);
b(1)=200;b(2)=500;b(3)=300;
Aeq=coef*weight;Aeq=Aeq';
    ind=find(cateData.ID==238);
    cbts=cateData.CBTS(ind);
    epds=cateData.EPDS(ind);
    hads=cateData.HADS(ind);
    init=[cbts,epds,hads];
    select=sol(2,:);x=sol(1,:);
    init(select)=init(select)+x;
    init=zscore(init);
    s=score(ind,:)';
    present=sum(weight.*s);
    dScore=-0.1-present;
    dSleep=barr(1)-scoreSleep(ind);
    costAny=zeros(1,7);
    for i=1:7
        select=[];
        if (floor(i/4)==1)
            select=[select,1];
        end
        if (floor(mod((i/2),2))==1)
            select=[select,2];
        end
        if (floor(mod(i,2))==1)
            select=[select,3];
        end
        costAny(i)=sum(b(select))+CalcProgram(select,init,Aeq,dSleep);
    end
    clear i j k
    cost=min(costAny);

