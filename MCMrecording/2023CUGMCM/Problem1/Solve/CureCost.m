function cost=CureCost(ind)
    behavior=cateData.Behavior(ind);
    cbts=cateData.CBTS(ind);
    epds=cateData.EPDS(ind);
    hads=cateData.HADS(ind);
    s=score(ind,:);init=[cbts,epds,hads];
    present=sum(weight.*s);
    dScore=-0.1-present;
    dPhy=dScore/weight(1);
    cost=zeros(1,8);
    for i=1:8
        select=[];
        if ((i/4)==1)
            select=[select,1];
        end
        if (mod((i/2),2)==1)
            select=[select,2];
        end
        if (mod(i,2)==1)
            select=[select,3];
        end
        cost(i)=CalcProgram(select,init);
    end
    clear i j k
end

function cost=CalcProgram(select,init)
    k=zeros(1,3);
    k(1)=(2812-200)/(3-0);
    k(2)=(1890-500)/(2-0);
    k(3)=(12500-300)/(5-0);
    b=zeros(1,3);
    b(1)=200;b(2)=500;b(3)=300;
    b=b(select);k=k(select);init=init(select);
    k=k./init;
    cost=sum(b);
end