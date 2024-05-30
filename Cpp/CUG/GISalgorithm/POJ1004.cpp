/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2024-05-30 15:40:00
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2024-05-30 15:51:08
 * @FilePath: \undefinedc:\Users\Administrator\GitHub\MyCoding\Cpp\CUG\GISalgorithm\POJ1004.cpp
 * @Description:
 * @
 * @Copyright (c) 2024 by ChanningTong, All Rights Reserved.
 */
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
    std::cout<<'$'<<std::setiosflags(std::ios::fixed)<<std::setprecision(2)<<balance/MONTH<<std::endl;
    return 0;
}