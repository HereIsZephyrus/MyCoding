#include<iostream>
using namespace std;

int Power(int,int);
double Power(double,int);

int main(){
    int n{0};
    auto m;
    cin>>m>>n;
    cout<<Power(m,n)<<' ';
    cin>>m>>n;
    cout<<Power(m,n)<<enl;
    return 0;
}