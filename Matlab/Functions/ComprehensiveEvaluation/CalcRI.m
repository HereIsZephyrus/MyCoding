function RI=CalcRI(n,times)
    if (nargin==1)
        times=1000;
    end
    rng('shuffle');
    RI=0;maxEig=0;
    for i=1:times
        data=floor(9*rand(n)+1);
        reData=1./(data');
        data=data-tril(data);
        reData=reData-triu(reData);
        data=data+reData+eye(n);
        maxEig=maxEig+max(eig(data));
    end
    clear i;
    RI=(maxEig/times-n)/(n-1);
end