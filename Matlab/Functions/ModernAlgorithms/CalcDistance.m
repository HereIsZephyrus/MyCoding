function dis=CalcDistance(X,Y,range)
    dis=zeros(range+2);
    for i=1:1+range
        for j=i+1:1+range
            dis(i,j)=sqrt((X(i)-X(j))^2+(Y(i)-Y(j))^2);
        end
    end
    dis=dis+dis';
end