function len=CalcLineLen(x,beta)
    x_range = 5;%东西海里长度
    y_range = 4;%南北海里长度
    t=1852;
    tx=x-cotd(beta)*y_range;
    ty=tand(beta)*x;
    if (tx<0)
        len=ty/sind(beta);
    else
        len=y_range/sind(beta);
    end
end