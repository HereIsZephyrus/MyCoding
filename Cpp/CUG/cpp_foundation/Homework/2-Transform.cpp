#include<iostream>
#include<cstring>
using std::cin;
using std::cout;
using std::endl;
using std::string;

string s;
int main(){
    int Num,Digital=0;
    const char Bits[16]={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
    cin>>Num>>Digital;
    s=Bits[Num%Digital];
    Num/=Digital;
    while (Num){
        s=Bits[Num%Digital]+s;
        Num/=Digital;
    }
    cout<<s<<endl;
    cin.get();
    cin.get();
    return 0;
}