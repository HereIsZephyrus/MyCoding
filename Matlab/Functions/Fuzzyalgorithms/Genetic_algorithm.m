dai=100;
rng('shuffle');
A=J;
for k=1:dai
    B=A;
    for i=1:2:w
        F=2+floor(100*rand(1));%break point
        temp=B(c(i),F:102);
        B(c(i),F:102)=B(c(i+1),F:102);
        B(c(i+1),F:102)=temp;
    end

by=find(rand(1,w)<0.1);
if length(by)==0
    by=floor(w*rand(1))+1;
end
    C=A(by,:);
    for j=1:L3
        bw=2+floor(100*rand(1,3));
        bw=sort(bw);
        C(j,:)=C(j,[1:bw(1)-1,bw(2)+1:bw(3),bw(1):bw(2),bw(3)+1:102]);
    end
    G=[A;B;C];
TL=size(G,1);

[dd,IX]=sort(G,2);
temp(1,TL)=0;
for j=1:TL
    for i=1:101
        temp(j)=temp(j)+d(IX(j,i),IX(j,i+1));
    end
end
[DZ,IZ]=sort(temp);
A=G(IZ(1:w),:)
end

