/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2024-05-30 15:40:00
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2024-05-30 17:16:18
 * @FilePath: \GISalgorithm\POJ2013.cpp
 * @Description:
 * @
 * @Copyright (c) 2024 by ChanningTong, All Rights Reserved.
 */
#include<iostream>
#include<cstring>
#include<string>
#include<vector>
int main(){
    int n,count = 0;
    std::cin>>n;
    while(n){
        std::vector<std::string> names(n);
        for (int i = 0; i < n; i++)
            std::cin>>names[i];
        std::cout<<"SET "<<++count<<std::endl;
        for (int i = 0; i < n; i+=2)
            std::cout<<names[i]<<std::endl;
        for (int i = n - 1 - (n &1); i >= 0; i-=2)
            std::cout<<names[i]<<std::endl;
        std::cin>>n;
    }
    return 0;
}