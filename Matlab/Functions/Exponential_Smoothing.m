function [y_pre,err]=Exponential_Smoothing(y,alpha)
    n=length(y);
    m=length(alpha);
    yha(1,1:m)=(y(1)+y(2))/2; %Initial value
    for i=2:n
            yhat(1,:)=alpha*y(i-1)+(1-alpha).*yhat(i-1,:);        
    end
    err=sqrt(mean((repmat(y,1,m)-yhat).^2));
    y_pre=alpha*y(n)+(1-alpha).*yhat(n,:);
end