function [p1,p2]=CalcWidth(x0,y0,beta,theta,Z)
x_range = 5;%东西海里长度
y_range = 4;%南北海里长度
t=1852;
% 定义搜索范围和步长
if (x0<=0.002)
    return;
end
Eps=2.618;
for indx = 1:1000*x0-1
    x=x0-indx/1000;
    indy = ceil(((x - x0) / tand(beta) + y0)*1000);

    y=indy/1000;
    if (indy<=0 || indy>=y_range*1000)%有问题，先出界后进入的情况未考虑
        break;
    end
    h=Z(round(1000*x0-indx),indy)/t;
    
    dis=sqrt((x-x0)^2+(y-y0)^2);
    z=-dis*cotd(theta/2);
    if (abs(z-h)*t<Eps)
        break;
    end
end
p1.x=x;
p1.y=y;
dis=sqrt((x-x0)^2+(y-y0)^2);
p1.dis=dis;
for indx = 1000*x0+1:x_range*1000-1
    x=indx/1000;
    indx=  round(indx);
    indy = ceil(((x - x0) / tand(beta) + y0)*1000);
    y=indy/1000;
    if (indy<=0 || indy>=y_range*1000)%有问题，先出界后进入的情况未考虑
        break;
    end
    h=Z(indx,indy)/t;
    dis=sqrt((x-x0)^2+(y-y0)^2);
    z=-dis*cotd(theta/2);
    if (abs(z-h)*t<Eps)
        break;
    end
end
p2.x=x;
p2.y=y;
dis=sqrt((x-x0)^2+(y-y0)^2);
p2.dis=dis;
end

