function [quantity,period,cost] = EOD(rateDemand,costOrder, ratePersistence ,price)
    %订购-折扣模型(economic ordering discount)订阅量越大，商品价格越低
    %   rateDemand为需求率,costOrder为订货费,ratePersistence为存储费率,price为价格折扣矩阵
    %   price第一列尾价格，第二列为区间下限，第三列为区间上限
    %   quantity为每次订货数量,period为订货周期间隔,cost为平均每周期成本
    %   [quantity,period,cost] = EOQ(rateDemand, costOrder,ratePersistence,price)
    numRange=size(price,1);
    quantity=sqrt(2*costOrder*rateDemand/(price(1,1)*ratePersistence));
    cost=1/2*ratePersistence*price(1,1)*quantity+...\%年平均存储费用
        costOrder*rateDemand/quantity+...\%年平均订货费用
        price(1,1)*rateDemand;%商品购买费用

    for i=2:numRange
        tempQuantity=sqrt(2*costOrder*rateDemand/(price(i,1)*ratePersistence));
        if (tempQuantity<price(i,2))
            tempQuantity=price(i,2);
        end
        if (tempQuantity>price(i,3))
            tempQuantity=price(i,3);
        end
        tempCost=1/2*ratePersistence*price(i,1)*tempQuantity+costOrder*rateDemand/tempQuantity+price(i,1)*rateDemand;
        if (tempCost<cost)
            quantity=tempQuantity;
            cost=tempCost;
        end
    end
    clear i;
    period=quantity/rateDemand;
end