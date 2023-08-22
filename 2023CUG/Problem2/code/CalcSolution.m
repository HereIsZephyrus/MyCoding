function sol=CalcSolution(p,A,B,C,Obj,quantity)
    % 单个箱子放置方案的求解函数
    % p为当前订单物体数量需求向量,(A,B,C)为当前空间的三维,quantity为当前已安排物体数量向量
    % Obj为当前订单中对当前规格箱子的简单组合体类别排列,table类型
    % 包含体积Volume,numL,numW,numH,L,W,H,cate
    q=length(Obj.cate);len=length(p);
    q = length(Obj.cate);
    len = length(p);
    sol = zeros(1, len);
    rotate=perms(1:3);
    num=0;

    for i=1:6
        maxInd=FindMaxVol(A,B,C,Obj,rotate(i,:));
        if (ind==q+1)
            continue
        end
        for ind=maxInd:q
            loc=Obj(ind,:);
            L=Obj.L(ind); W=Obj.W(ind); H=Obj.H(ind);
            t=[L,W,H];t=t(rotate);
            L=t(1); W=t(2); H=t(3);

            if (L<=A && W<=B && H<=C)
                loc=Obj(ind,:);
               return
            end

            clear L W H t
            quantity=quantity+[zeros(1,loc.cate-1),loc.numL*loc.numW*loc.numH,zeros(1,len-loc.cate)];%又多安排了loc.numL*loc.numW*loc.numH这么多个loc.cate的物品
            solAbove=CalcSolution(p,loc.numL * loc.L,loc.numW * loc.W,C-loc.numH * loc.H,Obj,quantity);
            solBeside=CalcSolution(p,loc.numL*loc.L,B-loc.numW*loc.W,C,Obj,quantity);
            solAhead=CalcSolution(p,A-loc.numL*loc.L,B,C,Obj,quantity);
            for a=1:length(solAbove)
                for b=1:length(solBeside)
                    for c=1:length(solAhead)
                        num=num+1;
                       sol(num,:)=quantity+solAbove(a,:)+solBeside(b,:)+solAhead(c,:);
                    end
                end
            end
        end
        clear a b c
    end
    sol = unique(sol, 'rows'); % 去除重复的解
    clear i
end