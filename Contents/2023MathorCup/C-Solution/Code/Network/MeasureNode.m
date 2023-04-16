function Value=MeasureNode(node,edge,series)
    %Col1:最大收货量 Col2:最小收货量  Col3:平均收货量 Col4:收货总天数
    %Col1:最大发货量 Col2:最小发货量  Col3:平均发货量 Col4:发货总天数
    %Col6:最大邻接点数    Col7:最小邻接点数 Col8:平均邻接点数
    %Col9:最长流量不存在天数
    load Series.mat
    n=length(Gragh);
    ind_start=1;
    Value=zeros(num,9);
    while(ind_start<=n)
        ind_end=During(ind_start,Date,n);
        leftEdge=find(Time_end(ind_start:ind_end)==node);%寻找与左节点相邻个边
        leftNode=Time_start(leftEdge);%左节点下标
        rightEdge=find(Time_start(ind_start:ind_end==node);%寻找与右节点相邻个边
        rightNode=Time_end(rightEdge);%右节点下标
        
        tmp_flow=0;
        tmp_adj=0;
        for edge=1:length(leftEdge)%计算各类收获指标
            Value(1)=max(Value(1),Volume(edge));
            if (Volume(edge)>=0)
            end
        end
    
        ind_start=ind_end+1;
    end
    
end

function ind=During(init,Date,n)
    val=Date(init);
    for i=init:n
        if (Date(i)~=val)
            break
        end
    end
    if (i==n)
        ind=n;
    else
        ind=i-1;
    end
end