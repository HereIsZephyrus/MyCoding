function [a_pre,b_pre]=Secondary_Exponential_Smoothing(y,alpha)
    n=length(y);
    st1(1)=y(1);        st2(1)=y(1);
    for i=2:n
            st1(i)=alpha*y(i)+(1alpha)*st1(i-1);
            st2(i)=alpha*st1(i)+(1-alpha)*s2(i-1);
    end
    a_pre=2*st1-st2;
    b_pre=alpha/(1-alpha)*(s1-st2);
end