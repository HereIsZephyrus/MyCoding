function [Regression,Residual]=PCE(X,Y,contribution)
    %主成分估计Principal component estimate,
    %X为回归自变量矩阵,Y为自变量线性组合
    %Regression为原始变量回归方程系数向量,Residual为回归分析剩余标准差
    %Correspond=corrcoef(X);
    std_x=zscore(X);
    std_y=zscore(Y);
    [n,m]=size(X);
    %利用设计矩阵进行主成分分析,返回式c的列向量对应着主成分的系数
    %返回值s对应着Z矩阵(Z=XQ,Q为标准化正交阵),t返回的是特征值
    [coeff,score,latent]=pca(std_x);
    Contributions=cumsum(latent)/sum(latent);
    p=1;
    while (Contributions(p)<contribution)  
        p=p+1;
    end
    hg1=[ones(n,1),X]\Y;
    hg1=hg1';
    %Print(hg1,m);
    hg=score(:,1:p)\std_y;          %主成分变量的回归系数
    hg=coeff(:,1:p)*hg;              %标准化变量的回归方程系数
    Regression=[mean(Y)-std(Y)*mean(X)./std(X)*hg,std(Y)*hg'./std(X)]; %原始变量的回归方程系数
    %Print(Regression,m);
    Residual=sqrt(sum((X*Regression(2:end)'+Regression(1)-Y).^2)/(n-p-1));
end
function Print(vec,n)
    fprintf('y=%f',vec(1));
    for i=1:n
            fprintf('+%f*x%d',vec(i+1),i);
    end
    fprintf('\n');
end
