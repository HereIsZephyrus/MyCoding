/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-04-09 22:22:38
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-04-09 22:24:33
 * @FilePath: \Homework\5-2.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#include<iostream>

int main(){
    int n,m;
    std::cin>>n>>m;
    int **a = new int *[n];
    // Allocate memory for the columns of each row
    for (int i = 0; i < n; i++)
        a[i] = new int[m];
    for(int i=0;i<n;i++)
        for(int j=0;j<m;j++)
            std::cin>>a[i][j];
    std::cout<<m<<' '<<n<<std::endl;
    for(int i=0;i<m;i++){
        for(int j=0;j<n;j++)
            std::cout<<a[j][i]<<' ';
        std::cout<<std::endl;
    }
    delete[] a;
    std::cin.get();
    std::cin.get();
    return 0;
}