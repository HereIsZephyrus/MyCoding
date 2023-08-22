function [quantity,period,cost,storge,scheduling] = EPQ(rateDemand, rateProduction ,costOrder,costPersistence,costShortage)
    %生产-存储模型(economic production quantity)补充时间较长,生产可以立刻开始,需求速度为常数,生产速度为常数
    %   rateDemand为需求率,rateProduction为生产率,costOrder为订货费,costPersistence为存储费,costShortage为短缺费(缺省为不允许缺货)
    %   quantity为每次订货数量,period为订货周期间隔,cost为平均每天成本
    %   scheduling中为生产调度方案,shortage为缺货时间,product为生产时间,start为生产开始时间,
    %   [quantity,period,cost,storge,scheduling] = EPQ(rateDemand, rateProduction ,costOrder,costPersistence,costShortage)
    %   [quantity,period,cost,storge] = EPQ(rateDemand, rateProduction ,costOrder,costPersistence)
    if (rateProduction<=rateDemand)
        error("The speed of production is less than the speed of demand");
    end
    if (nargin<4)
        error("argument error");
    end
    if (nargin==5) %允许缺货
        tCost=costOrder*(1/costPersistence+1/costShortage);
        tRate=rateProduction/(rateDemand*(rateProduction-rateDemand));
    
        period=sqrt(2*tcost*tRate);
        quantity = rateDemand*period;
        cost=2*costOrder/period;
    
        shortage=costPersistence/(costPersistence+costShortage)*period;
        product=rateDemand/rateProduction*period;
        start=(rateProduction-rateDemand)/rateProduction*periodShortage;
        storge=rateDemand*(period-start-product);

        scheduling=table(shortage,product,start);
    else %不允许缺货
        tCost=costOrder/costPersistence;
        tRate=rateProduction*rateDemand/(rateProduction-rateDemand);
        quantity=sqrt(2*tCost*tRate);
        period=quantity/rateDemand;
        cost=2*costOrder/period;
        storge=(rateProduction-rateDemand)/rateProduction*quantity;
        scheduling=[];
    end
end
