function score=CalcPregTime(time)
    if ((time>=37) && (time<43))
        score=1;
    elseif (time<37)%26~37
        score=0.4+0.6/(1 + exp(-0.7*(time-31)));
    else%43-45
        score=1-1/(1 + exp(-2*(time-45)));
    end
end
