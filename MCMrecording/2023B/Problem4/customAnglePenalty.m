function penalty = customAnglePenalty(theta)
    % 检查是否有足够的输入参数
    if nargin < 1
        error('请输入开角角度 theta。');
    end
    
penalty =1-(theta-90)/(150-60);
end
