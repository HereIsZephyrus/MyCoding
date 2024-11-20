/*** 
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-14 18:50:19
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-03-14 18:52:32
 * @FilePath: \CUG\Practice1\1.cpp
 * @Description: 
 * @
 * @Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
#include<iostream>
using namespace std;

int main(){
    for (int i=1; i<=10; ++i){
        for (int j=1; j<=10-i; ++j)
            cout<<' ';
        for (int j=1; j<=2*i-1; ++j)
            cout<<'*';
        cout<<endl;
    }
    for (int i=9; i>=1; --i){
        for (int j=1; j<=10-i; ++j)
            cout<<' ';
        for (int j=1; j<=2*i-1; ++j)
            cout<<'*';
        cout<<endl;
    }
    cin.get();
    return 0;
}