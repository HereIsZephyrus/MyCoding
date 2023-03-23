function PrincipalComponent(X,Y)
    %主成分分析,X为回归自变量矩阵,Y为自变量线性组合
    Correspond=corrcoef(X);
    std_x=zscore(X);
    std_y=zscore(Y);
    %利用设计矩阵进行主成分分析,返回式c的列向量对应着主成分的系数
    %返回值s对应着Z矩阵(Z=XQ,Q为标准化正交阵),t返回的是特征值
    [coeff,score,t]=pca(std_x);
    Contribution=cumsum(t)/sum(t);
end