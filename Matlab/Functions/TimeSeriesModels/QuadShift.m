function [a_pre,b_pre]=QuadShift(y,n)
    m1=length(y);
    for i=1:m1-n+1
            yhat1(i)=sum(y(i:i+n-1))/n;
    end
    m2=length(yhat1);
    for i=1:m2-n+1
            yhat2(i)=sum(yhat1(i:i+n-1))/n;
    end
    %plot(1:21,y,'*');
    a_pre=2*yhat1(end)-yhat2(end);
    b_pre=2*(yhat1(end)-yhat2(end))/(n-1);
end