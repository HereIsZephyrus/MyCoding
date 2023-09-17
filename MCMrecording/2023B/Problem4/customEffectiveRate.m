function effectiveRate = customEffectiveRate(S, Sdelta, W, tau)
    % 检查是否有足够的输入参数
    if nargin < 4
        error('请输入 S, Sdelta, W 和 tau 参数。');
    end

    % 计算有效测量率
    m = length(S); % 获取Si的数量
    x1 = zeros(1, m);
    
    for i = 1:m
        integral_term = trapz(0:tau:W(i), W(i)); % 计算积分项



        xi(i) = (sum(integral_term) - Sdelta) / (20 * tau^2);

    end
        % 计算总的有效测量率，将每个子区间的结果相加
    effectiveRate = sum(xi);
        
end
