#include<iostream>
int split(int apple,int place){
    if (place == 1) return 1;
    if (apple == 1) return 1;
    if (place > apple) return split(apple,apple);
    if (place == apple) return 1+split(apple,place-1);
    if (place < apple) return split(apple-place,place)+split(apple,place-1);
    return 0;
}
void solve(){
    int n,m;
    std::cin>>m>>n;
    std::cout<<split(m,n)<<std::endl;
}
int main(){
    int t;
    std::cin>>t;
    while(t--)  solve();
    return 0;
}