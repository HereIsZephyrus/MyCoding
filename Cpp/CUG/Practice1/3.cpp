/*** 
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-14 18:59:24
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-03-14 18:59:43
 * @FilePath: \CUG\Practice1\3.cpp
 * @Description: 
 * @
 * @Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
#include<iostream>
using namespace std;

int main(){
    for (int i=1; i<=9; i++){
        for (int j=1; j<=i-1; j++)
            cout<<i<<"*"<<j<<"="<<i*j<<"\t";
        cout<<i<<"*"<<i<<"="<<i*i<<endl;
    }
    cin.get();
    cin.get();
    return 0;
}