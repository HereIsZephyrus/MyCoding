function Genes=GenerateParental(Population,EncodingLength)
    %遗传算法生成亲代种群(for TSP),1号基因为出发点
    %Population为种群大小,EncodingLength为染色体基因长度,Genes为种群染色体样本
    for p=1:Population
        Sequence=[1,randperm(EncodingLength)+1,1];  %生成个体基因序列
        Sequence=ImprovedCircle(Sequence);              %优化基因序列
        Genes(p,Sequence)=[1:1+EncodingLength,1];     %产生个体  
    end
    Genes=Genes/(EncodingLength+1);                      %标准化
end