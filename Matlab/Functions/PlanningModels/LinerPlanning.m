%example
clc;clear;
A=[2 1;1 1;0 1];
B=[10 8 7];
f=[4 3];
[x,fval]=linprog(-f,A,B,[],[],zeros(size(f)),[]);

%transport
clc;clear;
Cost=[4 12 4 11;2 10 3 9;8 5 11 6;];
tmpCost=Cost;
Output=[16 10 22];  R=length(Output);
Input=[8 14 12 14];   L=length(Input);
Total=sum(Output);
Trans=zeros(length(Output),length(Input));
Max=max(Cost,[],'all')+1;
while (Total)
    [Min,Index]=min(Cost,[],'all');
    Cost(Index)=Max;
    Row=mod(Index-1,R)+1;
    Col=fix((Index-1)/R)+1;
    Take=min(Output(Row),Input(Col));
    if ~Take
        continue;
    end
    Output(Row)=Output(Row)-Take;
    Input(Col)=Input(Col)-Take;
    Total=Total-Take;
    Trans(Row,Col)=Take;
end
Row=0;Col=0;Cost=tmpCost;
flag=1;
while (flag)
    flag=0;
    Check=zeros(R,L);
    Change=cell(R,L);
    for Row=1:R
        for Col=1:L
            if (Trans(Row,Col)) 
                continue;
            end
          [Check(Row,Col),Change{Row,Col}]=qCircle(Row,Col,1,Col,Cost,Trans,{[Row,Col]});
          disp(Change{Row,Col});
        end
    end
    disp(Trans);
    disp(Cost);
    [tmpMin,Local]=min(Check,[],'all');
    if (tmpMin<0)
        flag=1;
        rowline=mod(Local-1,R)+1;colum=fix((Local-1)/R)+1;
        Update=Change{rowline,colum};
        Trans(rowline,colum)=Trans(rowline,colum)+1;
        for v=2:length(Update)
            x=Update(v,1);y=Update(v,2);
            Trans(x,y)=Trans(x,y)+(-1)^v;
            disp(Trans(x,y));
            pause
        end
    end
    fprintf("ddddd\n");
    pause
end
trans
function [Ans,Trace]=qCircle(x,y,res,term,cost,trans,trace)
    if ((term==y)&&(mod(res,2)==0))
        Ans=(-1)^res*cost(x,y);
        trace(res,:)=[x,y];
        return;
    end
    Ans=0xFFFF;
    Ind=zeros(1,2);
    Trace=trace;
    if mod(res,2)==1
        for Colum=1:size(cost,2)
            if Colum==y || ~trans(x,Colum)
                continue;
            end
            [Res,tmptrace]=qCircle(x,Colum,res+1,term,cost,trans,trace);
            if (Res<Ans)
                Ans=Res; 
                Trace(res,:)=[x,Colum];
                Trace=Trace+tmptrace;
            end
        end
    else
        for Rowline=1:size(cost,1)
            if Rowline==x || ~trans(Rowline,y)
                continue;
            end
            [Res,tmptrace]=qCircle(Rowline,y,res+1,term,cost,trans,trace);
            if (Res<Ans)
                Ans=Res;
                Trace(res,:)=[Rowline,y];
                Trace=Trace+tmptrace;
            end
        end
    end
    Trace(res,:)={tmptrace,Ind};
    Ans=Ans+(-1)^(res-1)*cost(x,y);
end