function [CI,CR]=Check_Consistency(A,RI)
    %CI为一致性指标,CR为一致性比例,比如CR<0.1时一致性检验通过
    [V,D] = eig(A);
    Max_eig = max(max(D));
    [r,c]=find(D == Max_eig , 1);
    disp( V(:,c) ./ sum(V(:,c)) )  %特征值法求权重
    CI = (Max_eig - n) / (n-1);
    %RI=[0 0.0001 0.52 0.89 1.12 1.26 1.36 1.41 1.46 1.49 1.52 1.54 1.56 1.58 1.59];  %注意哦，这里的RI最多支持 n = 15
    CR=CI/RI(n);
end