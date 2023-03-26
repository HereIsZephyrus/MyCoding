/*** 
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-16 19:57:25
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-03-16 19:58:59
 * @FilePath: \CUG\3-2.cpp
 * @Description: 
 * @
 * @Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
#include<iostream>
using namespace std;

int gcd(int,int);
int main(){
    int a,b;
    cin>>a>>b;
    cout<<gcd(a,b)<<' '<<a*b/gcd(a,b);
    cin.get();
    cin.get();
    return 0;
}
int gcd(int a,int b){
    if (!b)   return a;
    return gcd(b,a%b);
}