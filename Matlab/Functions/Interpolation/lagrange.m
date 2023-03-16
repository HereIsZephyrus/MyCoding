function y=lagrange(x0,y0,x)
%x0,y0为原始数据点x为要插值的点y为插值的结果
    n=length(x0);   m=length(x);
    for i=1:m
        z=x(i);
        s=0.0;
        for k=1:n
            p=1.0;
            for j=1:N
                if j~=k
                    p=p*(z-x0(j))/(x0(k)-x0(j));
            end
            s=p*y0(k)+s;
        end
        y(i)=s;
        end
end