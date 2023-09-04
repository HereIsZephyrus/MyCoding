function Value=MeasureEdge(edge,Time_start,Time_end,Time_var)
    %Col1:最大流量 Col2:最小流量  Col3:平均流量 
    %Col4:最长流量存在天数 Col5:最长流量不存在天数  Col6:流量存在天数 
    %Col7:该边流量占左节点的总发货路径数比 Col8:该边流量占右节点的总收货流量比
    leftNode=Time_start(edge);
    leftEdge=find(Time_start==leftNode);
    rightNode=Time_end(edge);
    rightEdge=find(Time_end==rightNode);
    Value=zeros(1,8);
    Value(3)=mean(Time_var(edge,:));
    Value(6)=nnz(Time_var(edge,:));
    Value(7)=Value(7)+sum(sum(Time_var(leftEdge,:),1)); 
    Value(8)=Value(8)+sum(sum(Time_var(rightEdge,:),1));
    running=0;%当天是否有流量在跑,计算存在天数
    dayFlag=1;
    for day=1:365*2
        Value(1)=max(Value(1),Time_var(edge,day));
        Value(2)=min(Value(2),Time_var(edge,day));
        if (Time_var(edge,day)>0)
            if (running==0)
                Value(5)=max(Value(5),day-dayFlag);
                running=1;
                dayFlag=day;
            end
        else
            if (running==1)
                Value(4)=max(Value(4),day-dayFlag);
                running=0;
                dayFlag=day;
            end
        end
    end
    if (running==0)%统计最后没有更新的序列状态
        Value(5)=max(Value(5),day-dayFlag);
    else
        Value(4)=max(Value(4),day-dayFlag);
    end
    if (Value(7)~=0)
        Value(7)=Value(3)/Value(7);%流量占比    
    end
    if (Value(8)~=0)
        Value(8)=Value(3)/Value(8);%流量占比
    end
end