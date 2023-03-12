function [a,b]=LeastSquares_Line(x,y)
    x1=sum(x);     y1=sum(y);
    x2=sum(x.^2);   x1y1=sum(x.*y);
    n=length(x);
    a=(n*x1y1-x1*y1)/(n*x2-x1*x1);
    b=(y1-a*x1)/n;
end
