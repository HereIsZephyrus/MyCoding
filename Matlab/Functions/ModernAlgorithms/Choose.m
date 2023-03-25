function superior=Choose(A,B,C)
    %遗传算法选择优秀基因型作为新的亲本(for TSP)
    %A,B,C分别为待选择的基因型
    global dis;
    Merge=[A;B;C];
    [Total,EncodingLength]=size(Merge);
    EncodingLength=EncodingLength-1;
    [loc,ind1]=sort(Merge,2);       %整合三个种群
    temp=zeros(1,Total);
    for j=1:Total
        for i=1:EncodingLength
            temp(j)=temp(j)+dis(ind1(j,i),ind1(j,i+1));     %计算出每个基因的适应度
        end
    end
    [Rank,ind2]=sort(temp);         %选择
    superior=Merge(ind2(1:Total/3),:); 
end