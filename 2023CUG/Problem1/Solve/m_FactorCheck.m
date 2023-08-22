function [residual,common,contribution]=m_FactorCheck(matrix,ind)
    %因子分析Factor Analysis,Matrix为数据矩阵
    %contribution为累计贡献率系数向量,residual为因子的残差矩阵
    matrix=zscore(matrix);                  %数据的标准化
    Correspond=corrcoef(matrix);      %计算相关系数矩阵Correspond
    %下面利用相关系数矩阵进行主成分分析，vec1的第一列为Correspond的第一特征向量，即主成分的系数
    [rate,latent,con]=pcacov(Correspond);                 %latent为Correspond的特征值，rate为各个主成分的贡献率
    f1=repmat(sign(sum(rate)),size(rate,1),1);               %构造与vec1同维数的元素为±1的矩阵用于求正分量
    rate=rate.*f1;             %修改特征向量的正负号，使得每个特征向量的分量和为正，即为最终的特征向量
    f2=repmat(sqrt(latent)',size(rate,1),1);
    factormat=rate.*f2;                  %构造全部因子的载荷矩阵
    sub=factormat(:,ind);                      %计算两个因子时的载荷矩阵
    tsquare=diag(Correspond-sub*sub');          %计算两个因子的特殊方差
    residual=Correspond-sub*sub'-diag(tsquare);             %计算两个因子时的残差矩阵
    common=sum(sub.^2,2);
    contribution=cumsum(con);
end