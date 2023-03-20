function [quantity,period_stoage,period_shortage,cost] = EPQ(rate_demand, rate_production ,cost_setup,cost_hold,cost_shortage)
    %经济生产批量存储模型[economic production quantity]:允许缺货,补充时间较长
    %需求是连续的
    %生产可以立刻开始但是补充需要一定时间,生产是连续的但是需要一定周期
    %rate_demand为需求率,rate_production为生产率,cost_setup为订货费,cost_hold为存储费,cost_shortage为短缺费
    %[quantity,period_stoage,period_shortage,cost] = EPQ(rate_demand, rate_production ,cost_setup,cost_hold,cost_shortage)
    quantity = round(sqrt((2 *rate_demand * cost_setup *(cost_hold+cost_shortage))/ ...
                                      (cost_hold*cost_shortage*(1-(rate_demand/rate_production)))));
    period_stoage=quantity/rate_demand;
    period_shortage=cost_hold/(cost_hold+cost_shortage)*period_stoage;
    cost=(rate_production-rate_demand)*rate_demand/(2*rate_production)*(cost_hold*period_stoage-2*cost_hold*period_shortage+(cost_hold+cost_shortage)*period_shortage^2/period_stoage+cost_setup/period_stoage);
end
