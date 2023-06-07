/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-05-26 20:28:46
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-05-26 20:29:24
 * @FilePath: \Cpp\CUG\test2.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#include<iostream>
#include<cstddef>
#include<typeinfo>
using namespace std;

void fun1(int);
int main(){
    void fun1(double);
    fun1(1);
    return 0;
}
void fun1(int i){
    cout<<"int:"<<i<<endl;
}
void fun1(double i){
    cout<<typeid(typeid(cout<<i)).name()<<endl;
    cout<<"double:"<<i<<endl;
}