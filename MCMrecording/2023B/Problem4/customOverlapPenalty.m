function penalty = customOverlapPenalty(eta, epsilon)
    % 检查是否有足够的输入参数
    if nargin < 2
        error('请输入重叠率 eta 和惩罚系数 epsilon。');
    end
    
    % 计算重叠惩罚函数
    penalty = exp(-eta * epsilon * sum(eta > 0.2));
end
