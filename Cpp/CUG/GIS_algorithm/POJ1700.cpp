/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2024-05-31 21:18:51
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2024-05-31 21:19:08
 * @FilePath: \GISalgorithm\POJ1700.cpp
 * @Description:
 * @
 * @Copyright (c) 2024 by ChanningTong, All Rights Reserved.
 */
#include<iostream>
#include<vector>
#include<algorithm>

void solve(){
    int n;
    std::cin>>n;
    std::vector<int> a(n),f(n);
    for (int i = 0; i<n; i++) std::cin>>a[i];
    std::sort(a.begin(),a.end());
    f[0] = a[0]; f[1] = a[1];
    for (int i = 2; i<n; i++)
        f[i] = std::min(f[i-1]+a[0]+a[i],f[i-2]+a[i]+a[0]+a[1]*2);
    std::cout<<f.back()<<std::endl;
    return;
}
int main(){
    int t;
    std::cin>>t;
    while (t--) solve();
    return 0;
}