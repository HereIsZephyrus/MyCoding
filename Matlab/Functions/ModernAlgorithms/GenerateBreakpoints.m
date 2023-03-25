function ind=GenerateBreakpoints(range,num)
    %生成用于交换的1*n的系数向量
    rng("shuffle");
    ind=ceil(range*rand(1,num));
    ind=unique(ind);
	while (length(ind)<num)
		ind=ceil(range*rand(1,num));
        ind=unique(ind);
    end
end