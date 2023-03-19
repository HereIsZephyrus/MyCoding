function [f,UV]=JohnsonSquare(tx,Time,n,m)
%n/m/F/Fmax问题解法Johnson部分
    U=find(tx(1,:)<=tx(2,:));
    V=find(tx(1,:)>tx(2,:));
    timeU=tx(U,1);      timeV=tx(V,2);
    [stU,ind1]=sort(timeU);                %对时间按照大小排序
    [stV,ind2]=sort(timeV,'descend');  %对时间按照大小排序
    UV=[U(ind1);V(ind2)];
    st=Time(UV,:);
    c(1,:)=cumsum(st(1,:));
    c(2:n,1)=c(1,1)+cumsum(Time(2:n,1));%求工件1的加工结束时间
    for i=2:n
        for k=2:m
            c(i,k)=max(c(i-1,k),c(i,k-1))+st(1,k);
        end
    end
    f=c(end);
end