function Value=MeasureNode(node,Time_start,Time_end,Time_var)
    %Col1:最大收货量 Col2:最小收货量  Col3:平均收货量 
    %Col4:最大发货量 Col5:最小发货量  Col6:平均发货量 
    %Col7:收货总天数 Col8:发货总天数  Col9:同时发货总天数
    %Col9:最大邻接点数    Col10:最小邻接点数 Col12:平均邻接点数
    Value=zeros(1,12);
    leftEdge=find(Time_end==node);%寻找与左节点相邻个边
    rightEdge=find(Time_start==node);%寻找与右节点相邻个边
    for day=1:365*2
        tmpValue=zeros(1,3);
        %Col1收货量
        %Col2发货量
        %Col3邻接点数
        for edge=1:length(leftEdge)%计算收货指标:1+3
            tmpValue(1)=tmpValue(1)+Time_var(edge,day);
            tmpValue(3)=tmpValue(3)+(Time_var(edge,day)>=0);
        end
        for edge=1:length(rightEdge)%计算发货指标:2+3
            tmpValue(2)=tmpValue(2)+Time_var(edge,day);
            tmpValue(3)=tmpValue(3)+(Time_var(edge,day)>=0);
        end
        Value(1)=max(Value(1),tmpValue(1));
        Value(2)=min(Value(2),tmpValue(1));
        Value(3)=Value(3)+tmpValue(1);
        Value(4)=max(Value(4),tmpValue(2));
        Value(5)=min(Value(5),tmpValue(2));
        Value(6)=Value(6)+tmpValue(2);
        Value(7)=Value(7)+(tmpValue(1)>0);
        Value(8)=Value(8)+(tmpValue(2)>0);
        Value(9)=Value(9)+((tmpValue(1)+tmpValue(2))>0);
        Value(10)=max(Value(10),tmpValue(3));
        Value(11)=min(Value(11),tmpValue(3));
        Value(12)=Value(12)+tmpValue(3);
    end
    if (Value(7)~=0)
        Value(3)=Value(3)/Value(7);
    end
    if (Value(8)~=0)
        Value(6)=Value(6)/Value(8);
    end
    if (Value(9)~=0)
        Value(12)=Value(12)/Value(9);
    end
end
