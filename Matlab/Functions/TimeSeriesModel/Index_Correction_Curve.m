function [a,b,k,y_pre]=Index_Correction_Curve(y,t)
%利用三合法求解,检验方法是看给定数据的逐期增长量的比率是否接近某一常数b
    n=length(y);
    m=n/3;
    cf=diff(y);
    for i=1:n-2
       bzh(i)=cf(i+1)/cf(i);
    end
    range=minmax(bzh);%检查修正指数曲线的拟合程度
    s1=sum(y(1:m));     s2=sum(y(m+1:2*m));     s3=sum(y(2*m+1:end));
    b=((s3-s2)/(s2-s1))^(1/m);
    a=(s2-s1)*(b-1)/(b*(b^m-1)^2);
    k=(s1-a*b*(b^m-1)/(b-1))/m;
    y_pre=k+a*b.^t;
end