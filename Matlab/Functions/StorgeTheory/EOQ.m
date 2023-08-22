function [quantity,period,cost] = EOQ(rateDemand, costOrder,costPersistence,costShortage)
    %订购-存储模型(economic ordering quantity)不允许缺货,生产时间近似0,需求是连续的均匀的
    %   rateDemand为需求率,costOrder为订货费,costPersistence为存储费,costShortage是短缺费
    %   quantity为每次订货数量,period为订货周期间隔,cost为平均每周期成本
    %   [quantity,period,cost] = EOQ(rateDemand, costOrder,costPersistence)
    %   [quantity,period,cost] = EOQ(rateDemand, costOrder,costPersistence,costShortage)
    if (nargin<3)
        error("argument error");
    end
    if (nargin==3)%不允许缺货
        quantity = sqrt((2 * rateDemand * costOrder) / costPersistence);
        period=quantity/rateDemand;
        cost=sqrt(2*costOrder*costPersistence*rateDemand);
    else%允许缺货
        tCost=costOrder*(1/costPersistence+1/costShortage);
        quantity=sqrt(2*tCost*rateDemand);
        period=quantity/rateDemand;
        cost=2*costOrder/period;
    end
end
