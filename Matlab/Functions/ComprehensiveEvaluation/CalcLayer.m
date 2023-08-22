function [weight,CR,maxEig]=CalcLayer(rawData)
    %计算AHP单层权重
    [weight,rawDiag]=eig(rawData);
    rawEig=diag(rawDiag);
    n=length(rawEig);
    [maxEig,maxInd]=max(rawEig);
    weight=weight(:,maxInd);
    weight=weight/sum(weight);
    RI=[0.58,0.90,1.12,1.24,1.32,1.41,1.45,1.49,1.51,1.54,1.56];
    if n>2
        CI=(maxEig-n)/(n-1);
        CR=CI/RI(n-2);
    else
        CR=0.0;
    end
    if (CR>0.1)
        disp('CR>0.1, please check the data');
    end
end