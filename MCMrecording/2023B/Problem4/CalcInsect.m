function [a,b,sd]=CalcInsect(x01,x02,beta,theta,Z)
    x_range = 5;%东西海里长度
    y_range = 4;%南北海里长度
    if (x02<=0 || x02>=x_range)
        return;
    end
    t=1852;
    Td=0;
    a=0;b=0;
    % 已知点和斜率
    k=-tand(beta);%斜率
    
    syms x
    equation_L = k * (x - x01) + 0;

    d=(x02-x01)/sind(beta);

    for i=1:5:2*x_range*t*1000
        [x2,y2]=CalcRoundXY(x02,0,i/1000,beta);
        if (y2>=y_range)%有问题，还差一点的
            break;
        end

if x2<2e-3
break;
end

        k_perpendicular = -1 / k; % 垂直线的斜率
        equation_perpendicular = k_perpendicular * (x - x2) + y2;
    
        % 解联立方程组，找到交点坐标
        x_intercept = solve(equation_L == equation_perpendicular, x);
        y_intercept = subs(equation_L, x, x_intercept);
        % 显示结果
    
        InterX2=double(x_intercept);
        InterY2=double(y_intercept);
    
        [InterX2,InterY2]=CalcRoundXY(InterX2,InterY2,0,beta);

%fprintf('(x1,y1) (x2,y2):(%.4f,%.4f)(%.4f,%.4f)\n', x2,y2,InterX2,InterY2);
        [pf1,pf2]=CalcWidth(InterX2,InterY2,beta,theta,Z);
        [pb1,pb2]=CalcWidth(x2,y2,beta,theta,Z);
        %...算重叠率得到a,b,sd
        %a>20,b<0,sd是漏测面积 d-pf2.dis-pb1.dis
        %重叠率 n=1-d/W,W=W1+W2,W1=sqrt(pbf与中心点的距离，)
        W=2*(pf2.dis+pb1.dis);
        n=1-d/W;
% disp(n)
%fprintf('间距 重叠率 宽度%.4f %.4f %.4f %.4f\n', d,n,pf2.dis,pb1.dis);

        if n>0.2
        a=a+1;
        elseif n<0
        b=b+1;
        end

        ssd=d-W;
        Td=Td+ssd;

    end
    sd=(Td*1e-3)*t*t;
end

