function [Solution,Sum]=SA(Initial_Solution,range,begin_heat,end_heat,MarkovLength,Rate)
    % 模拟退火算法Simulated annealing
    % range为1*2系数向量标注样本上下限,heat为温度控制,MarkovLength为迭代次数,Rate为温度衰减函数
    % begin_heat--1;    end_heat--0.1^30;
    rng("shuffle");
    Solution=Initial_Solution;
    Heat=begin_heat;
    for layer=1:MarkovLength
        breakpoints=GenerateBreakpoints(range,2);
        cost=Distance(Solution,breakpoints);
        if (cost<0) || (exp(-cost/T)>rand(1))
            Solution=[Solution(1:breakpoints(1)-1),Solution(breakpoints(2):-1:breakpoints(1)),Solution(breakpoints(2)+1:range+2)];
            Sum=Sum+cost;
        end
        Heat=Heat*Rate;
        if (Heat<end_heat)
            break;
        end
    end
end

function dis=Distance(solution,points)
    dis=d(solution(points(1)-1),solution(points(2)))+d(solution(points(1)),solution(points(2)+1))- ...
           d(solution(points(1)-1),solution(points(1)))-d(solution(points(2)),solution(points(2)+1));
end