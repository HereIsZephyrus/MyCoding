function [a_pre,b_pre]=SecexpSmooth(y,alpha)
    n=length(y);
    st1(1)=y(1);        st2(1)=y(1);
    for i=2:n
            st1(i)=alpha*y(i)+(1-alpha)*st1(i-1);
            st2(i)=alpha*st1(i)+(1-alpha)*st2(i-1);
    end
    a_pre=2*st1-st2;
    b_pre=alpha/(1-alpha)*(st1-st2);
end