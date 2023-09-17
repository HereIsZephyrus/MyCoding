function s=CalcSdL1(x,beta,theta,Z)
    x_range = 5;%东西海里长度
    y_range = 4;%南北海里长度
    t=1852;
    tx=x-cotd(beta)*y_range;
    ty=tand(beta)*x;
    len=0;
    if (tx<0)
        s0=ty*x/2;
        len=ty/sind(beta);
    else
        s0=(tx+x)*y_range/2;
        len=y_range/sind(beta);
    end
    A1=CalcLineArea(x,0,len,beta,theta,Z);
    s=s0-A1;
end