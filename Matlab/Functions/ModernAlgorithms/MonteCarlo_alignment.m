function Result=MonteCarlo_alignment(Range,Length)
    %蒙特卡罗法寻找初始解(for TSP),Range为序列长度,Length为搜索层数
    global dis;
    Sum=inf;
    for i=1:Length
        solution=[1,1+randperm(Range),range+2];
        temp=0;
        for j=1:Range+1
                temp=temp+d(solution(j),solution(j+1));
        end
        if temp<Sum
            Result=solution;
            Sum=temp;
        end
    end
end