function [A1,A2]=CalcLineArea(x0,y0,s,beta,theta,Z)
    x_range = 5;%东西海里长度
    y_range = 4;%南北海里长度
    Eps=1.852;
    A1=0;A2=0;
    
    for i=1:s*1000
        [roundX,roundY]=CalcRoundXY(x0,y0,i/1000,beta);
        [p1,p2]=CalcWidth(roundX,roundY,beta,theta,Z);
        flag1=1;flag2=1;
        if (p1.x<=0 || p1.x >=x_range || p1.y<=0 || p1.y>=y_range)
            flag1=0;
        end
        if (p2.x<=0 || p2.x >=x_range || p2.y<=0 || p2.y>=y_range)
            flag2=0;
        end
        if (flag1>0)
            A1=A1+p1.dis*Eps;
        end
        if (flag2>0)
            A2=A2+p2.dis*Eps;
        end
    end
    A1=A1/1000;A2=A2/1000;
end