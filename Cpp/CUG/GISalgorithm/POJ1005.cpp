#include<iostream>
const float shrinkinRate = 40.0;
const float _PI = 3.1315926;

int main(){
    int n;
    std::cin>>n;
    for (int i = 0; i < n; i++){
        float x,y,r = 0;
        std::cin>>x>>y;
        int year = 0.5 * _PI * (x * x + y * y -1) / shrinkinRate + 1;
        std::cout<<"Property "<<i + 1<<": ";
        std::cout<<"This property will begin eroding in year "<<year<<"."<<std::endl;
    }
    std::cout<<"END OF OUTPUT."<<std::endl;
    return 0;
}