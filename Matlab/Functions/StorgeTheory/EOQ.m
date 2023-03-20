function [quantity,period,cost] = EOQ(rate_demand, cost_order,cost_hold)
    %经济订购批量存储模型[optimal_order_quantity]:不允许缺货,生产时间近似0
    %demand为需求率,cost_order为订货费,cost_hold为存储费
    %quantity,period,cost] = EOQ(rate_demand, cost_order,cost_hold)
    quantity = round(sqrt((2 * rate_demand * cost_order) / cost_hold));
    period=quantity/rate_demand;
    cost=1/2*cost_hold*quantity+cost_order*rate_demand/quantity;
end

%optimal_order_quantity = economic_ordering_quantity(D, S, H);
%disp(['Optimal order quantity: ', num2str(optimal_order_quantity)]);