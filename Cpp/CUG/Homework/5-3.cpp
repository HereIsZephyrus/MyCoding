/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-04-09 22:40:43
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-04-09 23:23:36
 * @FilePath: \undefinedc:\Users\Administrator\GitHub\MyCoding\Cpp\CUG\Homework\5-3.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-04-09 22:40:43
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-04-09 23:19:33
 * @FilePath: \undefinedc:\Users\Administrator\GitHub\MyCoding\Cpp\CUG\Homework\5-3.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */

#include<iostream>

constexpr int None=-1;
int main(){
    static constexpr int N = 4;
    int a[N][N];
    bool exist = false;
    for (int i=0; i<N; ++i)
        for (int j=0; j<N; ++j)
            std::cin >> a[i][j];
    for (int i=0; i<N; ++i){
        int Max=-1,loc=-1;
        for (int j=0; j<N; ++j)//找到每一行的最大值
            if (a[i][j]>Max){
                Max=a[i][j];
                loc=j;
            }
        bool flag=true;
        for (int j=0; j<N; ++j)//检查是否为每一列的最小值
            if (a[j][loc]<Max){
                flag=false;
                exist=true;
                break;
            }
        if (flag)
            std::cout<<i<<' '<<loc<<' '<<Max<<std::endl;
    }
    if (!exist)
        std::cout<<None<<std::endl;
    std::cin.get();
    std::cin.get();
    return 0;
}