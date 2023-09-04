function [Res,fig]=Clustering_2023ICM(Matrix,Method,Num,Country)
    %系统聚类分析,Matrix为目标分析矩阵,Method为距离计算方法,Num为类的数量
    %返回结果为每一类的对象归类的向量
    n=size(Matrix,1);
    Matrix=zscore(Matrix);                  %数据标准化
    Distance=pdist(Matrix);                            %求对象间的欧氏距离
    z=linkage(Distance,Method);        %按指定方法生成聚类 
    fig=figure(4);
    dendrogram(z,'Labels',Country(1:n));
    T=cluster(z,'maxclust',Num);
    
    Res=zeros(n,1);
    for i=1:Num
        Target=(T==i);
        Res(Target)=i;
    end
end