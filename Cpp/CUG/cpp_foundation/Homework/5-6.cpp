/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-04-09 22:56:34
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-04-09 23:08:55
 * @FilePath: \undefinedc:\Users\Administrator\GitHub\MyCoding\Cpp\CUG\Homework\5-6.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#include<iostream>

constexpr int N=17;
const int m=3;
int main(){
    int leftBehind=N,p=0,count=1;
    bool Is_Out[N];
    for (int i=0; i<N; ++i)
        Is_Out[i]=false;
    while (leftBehind){
        if (count%m==0){
            //std::cout<<p<<' ';
            --leftBehind;
            Is_Out[p]=true;
            if (leftBehind==0)
                break;
        }
        ++count;
        p = (p + 1) % N;
        while (leftBehind && Is_Out[p])
            p = (p + 1) % N;
        //std::cout<<count<<' '<<leftBehind<<std::endl;
        //system("pause");
    }
    std::cout<<p<<std::endl;
    std::cin.get();
    return 0;
}