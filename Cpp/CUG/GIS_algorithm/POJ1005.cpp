/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2024-05-30 15:40:00
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2024-05-30 15:58:49
 * @FilePath: \undefinedc:\Users\Administrator\GitHub\MyCoding\Cpp\CUG\GISalgorithm\POJ1005.cpp
 * @Description:
 * @
 * @Copyright (c) 2024 by ChanningTong, All Rights Reserved.
 */
#include<iostream>
const float shrinkinRate = 50.0;
const float _PI = 3.1415926;

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