function [stf,ind]=PCA(Matrix)
    %主成分分析Principal Component Analysis,Matrix为数据矩阵
    %stf为综合得分排序特征值矩阵,ind为对应的样本编号
    Matrix=zscore(Matrix);                  %数据的标准化
    Correspond=corrcoef(Matrix);      %计算相关系数矩阵Correspond
    %下面利用相关系数矩阵进行主成分分析，vec1的第一列为Correspond的第一特征向量，即主成分的系数
    [vec1,latent,rate]=pcacov(Correspond);                 %latent为Correspond的特征值，rate为各个主成分的贡献率
    f=repmat(sign(sum(vec1)),size(vec1,1),1);               %构造与vec1同维数的元素为±1的矩阵用于求正分量
    vec2=vec1.*f;             %修改特征向量的正负号，使得每个特征向量的分量和为正，即为最终的特征向量
    num = max(find(latent>1,'last')); %num为选取的主成分的个数,这里选取特征值大于1的
    score=Matrix*vec2(:,1:num);    %计算各个主成分的得分
    tf=score*rate(1:num)/100;    %计算综合得分
    [stf,ind]=sort(tf,'descend'); 
    stf=stf';       ind=ind';           
end