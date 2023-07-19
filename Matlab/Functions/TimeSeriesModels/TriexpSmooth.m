function [aPre,bPre,cPre]=TriexpSmooth(y,alpha)
    n=length(y);
    st1_0=mean(y(1:3));         st2_0=st1_0;        st3_0=st1_0;
    st1(1)=alpha*y(1)+(1-alpha)*st1_0;
    st2(1)=alpha*st1(1)+(1-alpha)*st2_0;
    st3(1)=alpha*st2(1)+(1-alpha)*st3_0;
    for i=2:n
        st1(i)=alpha*y(i)+(1-alpha)*st1(i-1);
        st2(i)=alpha*st1(i)+(1-alpha)*st2(i-1);
        st3(i)=alpha*st2(i)+(1-alpha)*st3(i-1);
    end
    st1=[st1_0,st1];        st2=[st2_0,st2];        st3=[st3_0,st3];
    aPre=3*st1(n)-3*st2(n)+st3(n);
    bPre=0.5*alpha/(1-alpha)^2*((6-5*alpha)*st1(n)-2*(5-4*alpha)*st2(n)+(4-3*alpha)*st3(n));
    cPre=0.5*alpha^2/(1-alpha)^2*(st1(n)-2*st2(n)+st3(n));
end