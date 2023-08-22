function [coef,weight,score]=m_Factor(X,Y,num)
    %因子分析Factor Analysis,X为自变量矩阵,Y为因变量矩阵,num为主因子个数
    X=zscore(X);
    Correspond=cov(X);
    [rate,latent,con]=pcacov(Correspond);                 %latent为Correspond的特征值，rate为各个主成分的贡献率
    f1=repmat(sign(sum(rate)),size(rate,1),1);               %构造与vec1同维数的元素为±1的矩阵用于求正分量
    rate=rate.*f1;                                           %修改特征向量的正负号，使得每个特征向量的分量和为正，即为最终的特征向量
    f2=repmat(sqrt(latent)',size(rate,1),1);
    factormatOrigin=rate.*f2;                                     %构造全部因子的载荷矩阵
    factormatMain=factormatOrigin(:,1:num);
    [factormat_rotate,t]=rotatefactors(factormatMain,'Method','varimax');   %b为旋转后的矩阵,t为做变换的正交矩阵
    factmat=[factormat_rotate,factormatOrigin(:,num+1:end)];
    contribution=sum(factmat.^2);                               %计算各个因子的贡献
    rate=contribution(1:num)/sum(contribution);          %计算因子的贡献率
    coef=Correspond\factormat_rotate;                %计算得分函数的系数
    weight=rate/sum(rate);                                          %计算得分的权重
    score=X*coef;                                                   %计算每个因子的得分
end