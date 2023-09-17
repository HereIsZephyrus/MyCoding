function [X,Y]=CalcRoundXY(x,y,s,beta)
    X=x-s*cosd(beta);  
    Y=y+s*sind(beta);
    X=ceil(1000*X)/1000;Y=ceil(1000*Y)/1000;
end