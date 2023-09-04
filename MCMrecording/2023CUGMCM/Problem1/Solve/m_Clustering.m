function Res=m_Clustering(matrix,num)
    %系统聚类分析,Matrix为目标分析矩阵,Method为距离计算方法,Num为类的数量
    %返回结果为每一类的对象归类的矩阵
        matrix=zscore(matrix);                  %数据标准化
        Distance=pdist(matrix);                            %求对象间的欧氏距离
        z=linkage(Distance,"ward");        %按指定方法生成聚类 
        dendrogram(z);
        Res=cell(num,1);
        T=cluster(z,'maxclust',num);
        for i=1:num
            Target=find(T==i);
            Target=reshape(Target,1,length(Target));
            Res{i}=Target;
        end
end