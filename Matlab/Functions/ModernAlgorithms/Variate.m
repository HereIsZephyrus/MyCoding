function varied_genotype=Variate(initial_genotype,Rate)
    %遗传算法亲代变异得到新的种群基因型(for TSP)
    %initial_genotype为变异前种群基因型,varied_genotype为变异后种群基因型,Rate为变异率
    [Population,EncodingLength]=size(initial_genotype);
    EncodingLength=EncodingLength-1;
    Chosen=find(rand(1,Population)<Rate, 1);     %标记被变异的个体
    if (isempty(Chosen))                                     %如果都没人变异就找一个人变异
        Chosen=floor(Population*rand)+1;
    end
    varied_genotype=initial_genotype;
    numVaried=length(Chosen);
    for p=1:numVaried
        ind=GenerateBreakpoints(EncodingLength,3);  %使用三交换构造新的基因序列
        varied_genotype(Chosen(p),:)=varied_genotype(Chosen(p),[1:ind(1)-1,ind(2)+1:ind(3),ind(1):ind(2),ind(3)+1:EncodingLength+1]);
    end
end