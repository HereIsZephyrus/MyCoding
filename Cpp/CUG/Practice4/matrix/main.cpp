/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-04-30 20:07:40
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-05-20 10:30:12
 * @FilePath: \matrix\main.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#include<iostream>
#include<fstream>
#include"matrix.h"

int main(){
    Matrix<double> m(2,3);
    Matrix<int> m1(3,3),m2(3,3);
    std::cin>>m1>>m2;
    m1+m2;
    std::cout<<m1+m2<<std::endl;
    std::cout<<m1-m2<<std::endl;
    std::cout<<m1*m2<<std::endl;
    std::cout<<m1*2<<std::endl;
    std::cin.get();
    std::cin.get();
    return 0;
}