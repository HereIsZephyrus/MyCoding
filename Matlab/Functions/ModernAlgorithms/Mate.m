function Child=Mate(Parent,IntersectionNum)
    %遗传算法交配亲代得到子代(for TSP)
    %Parent为亲代种群基因型,IntersectionNum为交换基因的数量
    Child=Parent;
    [Population,EncodingLength]=size(Parent);
    EncodingLength=EncodingLength-1;
    for i=1:2:Population
        %利用Logistics混沌序列生成交叉基因座序列
        Locus0=rand;   Locus(1)=4*Locus0*(1-Locus0);
        for loc=2:IntersectionNum
            Locus(loc)=4*Locus(loc-1)*(1-Locus(loc-1));
        end
        Locus=1+ceil(EncodingLength*Locus);
        Locus=unique(Locus);
        %第i个个体与第i+1个个体交配,对应基因座交叉互换
        temp=Child(i,Locus);
        Child(i,Locus)=Child(i+1,Locus);
        Child(i+1,Locus)=temp;
    end
end