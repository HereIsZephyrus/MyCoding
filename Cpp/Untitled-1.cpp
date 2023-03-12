#include<iostream>
using std::cout;
using std::cin;
using std::endl;

int main(){
    int a,b,c,Max=0;
    cin>>a>>b>>c;
    Max=(a>b?a>c?a:c:b>c?b:c);
    cout<<Max<<endl;
    cin.get();
    cin.get();
    return 0;
}