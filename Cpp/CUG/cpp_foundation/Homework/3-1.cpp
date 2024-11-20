/*** 
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-12 17:16:01
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-03-16 19:55:33
 * @FilePath: \CUG\3-1.cpp
 * @Description: 
 * @
 * @Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
#include<iostream>
using namespace std;

int Power(int,int);
double Power(double,int);

int main(){
    int m,n,y;
    double x;
    cin>>m>>n>>x>>y;
    cout<<Power(m,n)<<' '<<Power(x,y)<<endl;
    cin.get();
    cin.get();
    return 0;
}

int Power(int a,int b){
    bool Is_positive=true;
    if (b<0){
        Is_positive=false;
        b=-b;
    }
    int res=1,base=a;
    for (int Index=b; Index; Index>>=1,base*=base)
        if (Index&1)    res*=base;
    if (Is_positive)    return res;
    else                return 1/res;
}

double Power(double a,int b){
    bool Is_positive = true;
    if (b < 0){
        Is_positive = false;
        b = -b;
    }
    double res=1,base=a;
    for (int Index=b; Index; Index>>=1,base*=base)
        if (Index&1)    res*=base;
    if (Is_positive)    return res;
    else                return double(1.0 / res);
}
