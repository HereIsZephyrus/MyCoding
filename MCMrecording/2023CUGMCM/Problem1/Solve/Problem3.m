clc;clear;close all;
load behaviorRegress.mat
load scoreData.mat
load regressData.mat
coef=coef(6:8,:)';weight=weight';
    b=zeros(1,3);
    b(1)=200;b(2)=500;b(3)=300;
Aeq=coef*weight;Aeq=Aeq';
ind=find(cateData.ID==238);
    cbts=cateData.CBTS(ind);
    epds=cateData.EPDS(ind);
    hads=cateData.HADS(ind);
    s=score(ind,:)';init=[cbts,epds,hads];
    present=sum(weight.*s);
    dScore=-0.1-present;
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
        [tmpCost,tmpX]=CalcProgram(select,init,Aeq,dScore);
        costAny(i)=sum(b(select))+tmpCost;
        if (i==1 || cost>costAny(i))
            cost=costAny(i);
            sol=[tmpX;select];
        end
        clear tmpCost tmpX
    end
    clear i j k
save Cure.mat costAny sol
