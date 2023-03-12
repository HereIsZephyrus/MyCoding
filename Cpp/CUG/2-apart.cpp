#include<iostream>
//#include<windows.h>
using std::cin;
using std::cout;
using std::endl;

int main(){
//    SetConsoleOutputCP(65001);
    int num,d1,d2,d3;
    cin>>num;
    d1=num%10;  d2=(num/10)%10; d3=num/100;
    cout<<"百位:"<<d3<<endl<<"十位:"<<d2<<endl<<"个位:"<<d1<<endl;
//    cout<<"Hundred:"<<d3<<endl<<"Ten:"<<d2<<endl<<"Bit:"<<d1<<endl;
    cin.get();
    cin.get();
    return 0;
}