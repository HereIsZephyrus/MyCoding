/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-04-30 20:07:40
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-04-30 21:22:58
 * @FilePath: \matrix\main.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#include<iostream>
#include<fstream>
#include"matrix.h"

int main(){
    Matrix<double,2,3> m;
    Matrix<int,3,3> m1,m2;
    std::cin>>m1>>m2;
    std::cout<<m1+m2<<std::endl;
    std::cout<<m1-m2<<std::endl;
    std::cout<<m1*m2<<std::endl;
    std::cout<<m1*2<<std::endl;
    std::cin.get();
    std::cin.get();
    return 0;
}