/*** 
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-14 18:54:38
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-03-14 19:04:00
 * @FilePath: \CUG\Practice1\2.cpp
 * @Description: 
 * @
 * @Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
#include<iostream>
using namespace std;

int main(){
    int a,b;
    char Rules;
    cin>>a>>Rules>>b;
    switch (Rules)
    {
    case '+':
        cout << a + b << endl;
        break;
    case '-':
        cout << a - b << endl;
        break;
    case '*':
        cout << a * b << endl;
        break;
    case '/':
        cout << (double)a / b << endl;
        break;
    default:
        cout<<"Incorrct Input!"<<endl;
    }
    cin.get();
    cin.get();
    return 0;
}