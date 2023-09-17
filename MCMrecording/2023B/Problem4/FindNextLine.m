function [xx,sd,a,b]=FindNextLine(x0,x,beta,theta,Z)
x_range = 5;%东西海里长度
    y_range = 4;%南北海里长度
dx=0;
[a,b,sd]=CalcInsect(x0,x,beta,theta,Z);
if (a>b)
    dx=(x-x0)/2;
else
    dx=(x-x0)/2;
end

minG=abs(a-b);
Ax=x;xx=x+dx;
beginHeat=50;endHeat=1;
Heat=beginHeat;
coolingRate = 0.9;

    for layer=1:50
        if (dx<0.001)
            break
        end
        [aa,bb,ssdd]=CalcInsect(x0,xx,beta,theta,Z);
        cost=abs(aa-bb)-minG;
         if (cost<0) || (exp(-cost/Heat)>rand(1))
             sd=ssdd;
             minG=abs(aa-bb);
             Ax=xx;
         end
         Heat=Heat*coolingRate;
         if (Heat<endHeat)
             break;
         end
         if (a>b)
            dx=abs(xx-x0)/2;
        else
            dx=abs(xx-x0)/2;
         end
         x0=xx;
         xx=xx+dx;
         if (xx<=0 || xx>=x_range)
             break;
         end
    end
end