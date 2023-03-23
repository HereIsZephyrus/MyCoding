function Res=Clustering(Leading,Matrix,Method,Num)
    %系统聚类分析,Leading为声明R/Q类分析,Matrix为目标分析矩阵,Method为距离计算方法,Num为类的数量
    %返回结果为每一类的对象归类的矩阵
    if Leading=='R'
        Correspond=corrcoef(Matrix); %计算相关系数
        Distance=1-Correspond;
        Distance=tril(Distance);            %化为三角矩阵
        Distance=nonzeros(Distance);
        Distance=Distance';
        z=linkage(Distance,Method);        %按指定方法生成聚类 
        figure("tree");
        dendrogram(z);
        Res={};
        T=cluster(z,'maxclust',Num);
        for i=1:Num
            Target=find(T==i);
            Target=reshape(Target,1,length(Target));
            Res(i,:)=Target;
        end
    end
    if Leading=='Q'
        Matrix=zscore(Matrix);                  %数据标准化
        y=pdist(Matrix);                            %求对象间的欧氏距离
        z=linkage(Distance,Method);        %按指定方法生成聚类 
        figure("tree");
        dendrogram(z);
        Res={};
        for k=2:Num
            T=cluster(z,'maxclust',Num);
            tmp={};
            for i=1:k
                Target=find(T==i);
                Target=reshape(Target,1,length(Target));
                tmp(i,:)=Target;
            end
            Res(k,:)=tmp;
        end
    end
end