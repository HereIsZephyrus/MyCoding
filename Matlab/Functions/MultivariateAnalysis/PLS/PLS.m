function PLS(data,n,m)
    mu=mean(data);
    sig=st(data);
    rr=corrcoef(data);
    std_data=zscore(data);
    X=data(:,1:n);
    Y=data(:,n+1:end);
    std_X=std_data(:,1:n);
    std_Y=std_data(:,n+1:end);
    num=length(Y,1);
    chg=eye(n);
    for i=1:n
        Matrix=std_X'*std_Y*std_Y'*std_X;
        [vec,val]=eig(Matrix);
        val=diag(val);
        [val,Index_Correction_Curve=sort(val,'descend')];
        w(:,i)=vec(:,ind(1));
        w_star(:,i)=chg*w(:,i);
        t(:,i)=std_X*w(:,i);
        alpha=std_X'*t(:,i)/(t(:,i)'*t(;,i));
        chg=chg*(ey(n)-w(:,i)*alpha');
        Residual=std_X-t(:,i)*alpha';
        std_X=Residual;
    end
    beta=t\std_Y;
    Residual=std_Y-t*beta;
    ss(i)=sum(sum(Residual.^2));
    for j=1:num
        t1=t(:,i:i);    
        y=std_Y;
        she_t=y(j,:);
        she_y=y(j,:);
        t1(j,:)=[];
        y(j,:)=[];
        beta1=[t1,ones(num-1),1]\f1;
        Residual=she_y-she_t*beta1(1:end-1,:)-beta1(end,:);
        press_i(j)=sum(Residual.^2);
    end

    
end