%function [optim_Fmax,optim_seq]=CDS(Time)
%n/m/F/Fmax问题解法
    Time=[1,2,6,3;8,4,2,9;4,5,8,2];
    [n,m]=size(Time);
    txm=[];
    Fmax=[];
    TUV=[];
    for k=1:m-1
            for i=1:n
                    tx(i,1)=sum(Time(i,1:k));
                    tx(i,2)=sum(Time(i,m+1-k:m));
            end
            [fmax,uv]=JohnsonSquare(tx,Time,n,m);
            Fmax=[Fmax,fmax];
            txm=[txm,tx];
            TUV=[TUV,uv];
    end
    disp(txm);
    disp(Fmax);
    disp(TUV);
    optim_Fmax=min(Fmax);
    ind=find(Fmax==optim_Fmax);
    optim_seq=TUV(:,ind);
%end