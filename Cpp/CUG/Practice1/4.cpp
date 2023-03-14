/*** 
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-14 19:07:11
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-03-14 19:08:35
 * @FilePath: \CUG\Practice1\4.cpp
 * @Description: 
 * @
 * @Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
#include<iostream>
#include<ctime>
#include<cstdlib>
using namespace std;

int main(){
    srand((unsigned int)time(0));
    int num=rand()*100;
    int Guess=-1;
    cout<<"I generate a number just now.Can you catch it?It ranges 0 to 99"<<endl;
    cin>>Guess;
    while (Guess!=num){
        cout<<"Pity!Not the number."<<endl;
        cin>>Guess;
    }
    return 0;
}