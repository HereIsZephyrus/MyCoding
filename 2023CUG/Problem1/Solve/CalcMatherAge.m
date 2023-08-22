function score=CalcMatherAge(age)
    if ((age>=22) && (age<29))%最佳生育年龄为22~29,在这个年龄段不区分年龄对生育的影响
        score=1;
    elseif (age<22)%18-22岁
        score=0.2+0.8/(1 + exp(-0.5*(age-20)));
    else%30-50岁
        score=1-0.8/(1 + exp(-0.2*(age-40)));
    end
end
