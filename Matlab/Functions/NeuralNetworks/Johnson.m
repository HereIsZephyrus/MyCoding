function [f,UV]=Johnson(Time,n,m)
%n/2/F/Fmax问题的最优解法
    n=size(Time,2);
    U=find(Time(1,:)<=Time(2,:));
    V=find(Time(1,:)>Time(2,:));
    timeU=Time(1,U);      timeV=Time(2,v);
    [stU,ind1]=sort(timeU);                %对时间按照大小排序
    [stV,ind2]=sort(timeV,'descend');  %对时间按照大小排序
    UV=[U(ind1),V(ind2)];
    st=Time(:,UV);
    ti1=cumsum(st(1,:));
    ti2(1)=ti1(1)+st(2,1);
    for j=2:n
        ti(j)=max(ti1(j),ti2(j-1))+st(2,j);
    end
    f=[ti1;ti2];
end