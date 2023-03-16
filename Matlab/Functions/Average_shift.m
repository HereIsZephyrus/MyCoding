%clc;clear
%load data; %data in y
function [y_pre,s]=Average_shift(y,n)
    m=length(y);
    for i=1:length(n)
        for j=1:m-n(i)+1
            yhat{i}(j)=sum( y(j:j+n(i)-1) ) / n(i);
        end
        y_pre(i)=yhat{i}(end);
        s(i)=sqrt( mean((y(n(i)+1:m)-yhat{i}(1:end-1)) .^2));
    end
end