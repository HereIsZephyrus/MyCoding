function [a,b,k,y_pre]=Logistic_Curve(xsh,t)
    y=1/xsh;     n=length(y);        m=n/3;
    s1=sum(y(1:m));     s2=sum(y(m+1:2*m));     s3=sum(y(2*m+1:end));
    b=((s3-s2)/(s2-s1))^(1/m);
    a=(s2-s1)*(b-1)/(b*(b^m-1)^2);
    k=(s1-a*b*(b^m-1)/(b-1))/m;
    y_pre=k+a*b.^t;
end