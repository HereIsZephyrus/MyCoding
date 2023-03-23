function [Contribution,Residual]=FactorCheck(Matrix)
    %因子分析Factor Analysis,Matrix为数据矩阵
    %Contribution为累计贡献率系数向量,Residual为因子的残差矩阵
    Matrix=zscore(Matrix);                  %数据的标准化
    Correspond=corrcoef(Matrix);      %计算相关系数矩阵Correspond
    %下面利用相关系数矩阵进行主成分分析，vec1的第一列为Correspond的第一特征向量，即主成分的系数
    [vec,latent,con]=pcacov(Correspond);                 %latent为Correspond的特征值，rate为各个主成分的贡献率
    f1=repmat(sign(sum(vec)),size(vec,1),1);               %构造与vec1同维数的元素为±1的矩阵用于求正分量
    vec=vec.*f1;             %修改特征向量的正负号，使得每个特征向量的分量和为正，即为最终的特征向量
    f2=repmat(sqrt(latent)',size(vec,1),1);
    factormat=vec.*f2;                  %构造全部因子的载荷矩阵
    sub1=factormat(:,1);                                    %计算一个因子时的载荷矩阵
    tsquare1=diag(Correspond-sub1*sub1');           %计算一个因子的特殊方差
    sub2=a(:,[1,2]);                                            %计算两个因子时的载荷矩阵
    tsquare2=diag(Correspond-sub2*sub2');         %计算两个因子的特殊方差
    Residual=r-sub2*sub2'-diag(tsquare2);             %计算两个因子时的残差矩阵
    Contribution=cumsum(con);
end