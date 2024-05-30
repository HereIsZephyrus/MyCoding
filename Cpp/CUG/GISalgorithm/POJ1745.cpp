#include<iostream>
#include<vector>
int main(){
    int n,k;
    std::cin>>n>>k;
    std::vector<int> a(n);
    for (int i = 0; i<n; i++){
        std::cin>>a[i];
    }
    std::vector<std::vector<bool> > f(n,std::vector<bool>(k,0));
    for (int i = 0; i<k; i++) f[0][i] = false;
    f[0][a[0]] = true;
    for (int i = 1; i<n; i++)
        for (int j = 0 ; j<k; j++)
            f[i][j] = f[i-1][(j+a[i])%k] || f[i-1][(j-a[i]+k)%k];
    if (f[n-1][0])  std::cout<<"Divisible"<<std::endl;
    else            std::cout<<"Not divisible"<<std::endl;
    return 0;
}