
#include<iostream>
#include<vector>
int toBound(int x,const int &k){
    int res = x;
    if (res <0 )  res %= k;
    res = (res + k)%k;
    return res;
}
int main(){
    int n,k;
    std::cin>>n>>k;
    std::vector<int> a(n);
    for (int i = 0; i<n; i++){
        std::cin>>a[i];
    std::vector<std::vector<bool> > f(n,std::vector<bool>(k));
    for (int i = 0; i<k; i++) f[0][i] = false;
    f[0][toBound(a[0],k)] = true;
    for (int i = 1; i<n; i++)
        for (int j = 0 ; j<k; j++)
            f[i][j] = f[i - 1][toBound(j + a[i],k)] || f[i - 1][toBound(j - a[i],k)];
    if (f[n-1][0])  std::cout<<"Divisible"<<std::endl;
    else            std::cout<<"Not divisible"<<std::endl;
    getchar();getchar();
    return 0;
}