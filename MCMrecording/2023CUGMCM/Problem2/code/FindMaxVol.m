function ind=FindMaxVol(A,B,C,Obj,rotate)
    len=length(Obj.cate);
    loc=[];
    for ind=1:len
        L=Obj.L(ind); W=Obj.W(ind); H=Obj.H(ind);
        t=[L,W,H];t=t(rotate);
        L=t(1); W=t(2); H=t(3);
        if (L<=A && W<=B && H<=C)
            loc=Obj(ind,:);
            return
        end
    end
    if (istable(loc)==0)
        ind=len+1;
    end
end