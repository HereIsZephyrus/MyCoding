function [Outstanding,Cost]=ImprovedCircle(Initial)
    %改良圈算法(For TSP),Initial为一个初始圈(首尾相接)可通过randperm多次生成,dis为距离矩阵
    % Outstanding为一个优胜解,Cost为该圈的最小代价
    %dis为CalcDistance中一个Global值
    global dis;
    num=length(Initial)-1;
    Outstanding=Initial;
    is_find=1;
    Cost=0;
    while is_find>0
        is_find=0;                         
        for Begin=1:num-2
            for End=Begin+2:num
                if dis(Outstanding(Begin),Outstanding(End))+dis(Outstanding(Begin+1),Outstanding(End+1))<dis(Outstanding(Begin),Outstanding(Begin+1))+dis(Outstanding(End),Outstanding(End+1))
                    %左闭右开,Begin=u-1,End=v
                    Outstanding(Begin+1:End)=Outstanding(End: -1 :Begin+1);       %更新路径
                    is_find=1;                                                                                  %找到了一个更优解
                end                       %即i+1-j之间的访问顺序颠倒
            end 
        end
        if is_find==0                        %已经找到一个相对较优解
            for n=1:num
                Cost=Cost+dis(Outstanding(n),Outstanding(n+1)); %求出起点经过中间城市然后到终点然后从终点直接回到起点的距离
            end
        end
    end
end
