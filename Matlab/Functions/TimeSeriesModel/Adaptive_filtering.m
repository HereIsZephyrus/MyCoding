function [y_pre,w]=Adaptive_filtering(y)
%N为权数个数,k为学习常数.当时间序列的观测值呈季节变动是，N应取季节性长度值.
    m=length(y);        Terr=10000;
    N=4;                    k=0.9;
    w=ones(1,N)/N;
    while abs(Terr)>0.001
            Terr=[];
            for j=N+1:m-1
                    yhat(i)=w*yt(j-1:-1:j-N)';
                    err=y(j)-yhat(j);
                    Terr=[Terr,abs(err)];
                    w=w+2*k*err*y(j-1:-1:j-N);
            end
            Terr=max(Terr);
    end
end