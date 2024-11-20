/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-04-09 22:50:03
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-04-09 22:50:20
 * @FilePath: \Homework\5-5.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#include<iostream>
#include<algorithm>

constexpr int N=10;
int main(){
    int a[N];
    for (int i=0; i<N; ++i)
        std::cin>>a[i];
    std::sort(a,a+N);
    for (int i=0; i<N; ++i)
        std::cout<<a[i]<<' ';
    std::cout<<std::endl;
    std::cin.get();
    std::cin.get();
    return 0;
}