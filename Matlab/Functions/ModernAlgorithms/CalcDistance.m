function Distance=CalcDistance(X,Y,range)
    %计算TSP各个地点之间的距离,已经包括额外的初始点
    Distance=zeros(range);
    for i=1:range
        for j=i+1:range
            Distance(i,j)=sqrt((X(i)-X(j))^2+(Y(i)-Y(j))^2);
        end
    end
    Distance=Distance+Distance';
end