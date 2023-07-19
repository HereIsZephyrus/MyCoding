function [y_pre,w]=AdaptiveFiltering(y,N,limit)
    %y为序列,N为权数个数,k为学习常数.当时间序列的观测值呈季节变动时，N应取季节性长度值.
    if (nargin<3)
        limit=0.01;
        if (nargin<2)
            N=4;
        end
    end
    m=length(y);        Terr=10000;
    k=0.9;
    w=ones(1,N)/N;
    while abs(Terr)>limit
            Terr=[];
            for j=N+1:m-1
                if (isnan(y(j)))
                    continue;
                end
                    y_pre(j)=w*y(j-1:-1:j-N)';
                    err=y(j)-y_pre(j);
                    Terr=[Terr,abs(err)];
                    w=w+2*k*err*y(j-1:-1:j-N);
            end
            Terr=max(Terr);
    end
end