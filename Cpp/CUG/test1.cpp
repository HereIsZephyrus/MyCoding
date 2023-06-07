/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-05-26 20:21:49
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-05-26 20:22:02
 * @FilePath: \Cpp\CUG\test1.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#include<iostream>
using namespace std;

int main()
{
    char c;
    int letters=0,digits=0,others=0;
    cout<<"Please input a line characters:"<<endl;
    while (cin>>c,c!='q')
    {
        if (c>='a' && c<='z' || c>='A' && c<='Z')
            letters++;
        else if (c>='0' && c<='9')
            digits++;
        else
            others++;
    }
    cout<<"letters="<<letters<<",digits="<<digits<<",others="<<others<<endl;
    cin.get();
    cin.get();
    return 0;
}