a=(n,m);
b=(1,M)';
z1=(n,1);
z2=(n,1);
...
[x1,g1]=linprog(z1,a,b,[],[],zeros(n,1));
[x2,g2]=linprog(z2,a,b,[],[],zeros(n,1));
...
g=[g1,g2,...]
[x,fval]=fgoalattain('Fun',rand(4,1),g,abs(g),a,b,[],[],zeros(n,1));