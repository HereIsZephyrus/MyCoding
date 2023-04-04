function [d,stats]=Factor_2023ICM(X,Y,num)
    %因子分析Factor Analysis,X为自变量矩阵,Y为因变量矩阵,num为主因子个数
    n=length(Y);
    X=zscore(X);
    Correspond=cov(X);
    [vec,latent,con]=pcacov(Correspond);                 %latent为Correspond的特征值，rate为各个主成分的贡献率
    f1=repmat(sign(sum(vec)),size(vec,1),1);               %构造与vec1同维数的元素为±1的矩阵用于求正分量
    vec=vec.*f1;                                                        %修改特征向量的正负号，使得每个特征向量的分量和为正，即为最终的特征向量
    f2=repmat(sqrt(latent)',size(vec,1),1);
    factormat_origin=vec.*f2;                                     %构造全部因子的载荷矩阵
    factormat_part=a(:,1:num);
    [factormat_rotate,t]=rotatefactors(factormat_part(:,1:2),'Method','varimax');   %b为旋转后的矩阵,t为做变换的正交矩阵
    factmat=[factormat_rotate,factormat_origin(:,num+1:end)];
    contribution=sum(factmat.^2);                               %计算各个因子的贡献
    rate=contribution(1:num)/sum(contribution);          %计算因子的贡献率
    coef=inv(Correspond)*factormat_rotate;                %计算得分函数的系数
    score=X*coef;                                                        %计算每个因子的得分
    weight=rate/sum(rate);                                          %计算得分的权重
    Tscore=score*weight';                                           %求出每个对象的综合得分
    [STscore,ind]=sort(Tscore,'descend');                     %对各因子的得分进行加权求和
    %[ccoef,p]=corrcoef([Tscore,Y]);                               %计算与
    %具体问题具体分析,得出回归系数和相关量
end