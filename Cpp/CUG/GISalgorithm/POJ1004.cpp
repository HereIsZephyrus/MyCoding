#include<iostream>
#include<iomanip>
const int MONTH = 12;
int main(){
    float balance = 0;
    for (int i = 0; i < MONTH; i++){
        float singleMonth;
        std::cin>>singleMonth;
        balance += singleMonth;
    }
    std::cout<<'$'<<std::setprecision(2)<<balance/MONTH<<std::endl;
    return 0;
}