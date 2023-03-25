function Result=MonteCarlo_alignment(Range,Length)
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