/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2024-05-30 15:40:00
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2024-05-30 16:58:37
 * @FilePath: \GISalgorithm\POJ1651.cpp
 * @Description:
 * @
 * @Copyright (c) 2024 by ChanningTong, All Rights Reserved.
 */
#include<iostream>
#include<vector>

int main(){
    int n;
    std::cin>>n;
    std::vector<std::vector<int> > f(n,std::vector<int>(n,0));
    std::vector<int> a(n);
    for (int i = 0; i<n; i++)   std::cin>>a[i];
    for (int len = 2; len<=n; len++)
        for (int i = 0; i+len<n; i++){
            int j = i+len;
            f[i][j] = 1e9;
            for (int k = i+1; k<j; k++)
                f[i][j] = std::min(f[i][j],f[i][k]+f[k][j]+a[i]*a[k]*a[j]);
        }
    std::cout<<f[0][n-1]<<std::endl;
    getchar();getchar();
    return 0;
}