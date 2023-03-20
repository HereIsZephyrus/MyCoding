% Constants
holding_cost = 1; % Holding cost per unit per year
demand = 1000; % Annual demand
order_cost = 50; % Cost to place an order

% Bulk discount price breaks
price_breaks = [0, 200, 400];
unit_costs = [10, 9, 8];

% Calculate EOQ for each price break
eoq = @(D, S, H) sqrt((2 * D * S) / H);
eoqs = EOQ(demand, order_cost, holding_cost);

% Initialize variables for optimal order quantity and total cost
optimal_order_quantity = 0;
min_total_cost = Inf;

% Iterate through price breaks and calculate total cost for each EOQ
for i = 1:length(price_breaks)
    order_quantity = max(eoqs(i), price_breaks(i));
    total_cost = (demand / order_quantity) * order_cost + demand * unit_costs(i) + (order_quantity / 2) * holding_cost;
    
    % Update optimal order quantity and total cost if current total cost is lower
    if total_cost < min_total_cost
        optimal_order_quantity = order_quantity;
        min_total_cost = total_cost;
    end
end

% Display results
fprintf('Optimal order quantity: %.2f\n', optimal_order_quantity);
fprintf('Minimum total cost: %.2f\n', min_total_cost);