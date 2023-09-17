function tolerance = customTolerance(S, mu)
    % 漏测宽容度常数
    if nargin < 2
        mu = 200000; % 默认中宽容度
    end
    
    % 计算宽容函数
    tolerance = exp(-S / (4 * 5 * mu));
end
