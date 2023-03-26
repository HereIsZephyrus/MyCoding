/*** 
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-25 22:01:58
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-03-25 22:34:42
 * @FilePath: \undefinedc:\Users\Administrator\GitHub\MyCoding\Cpp\CUG\Homework\4-4.cpp
 * @Description: 
 * @
 * @Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
#include<iostream>
#include<cstring>
#include<string>
using namespace std;

const double decrease=0.95;
struct Account{
    string name;
    int year;
    double deposit;
    double balanceRate;
};
double Power(double base, double exp,int year){
    double result = base,rate=exp;
    for(int i=1;i<year;i++){
        result*=(1+rate);
        rate*=decrease;
    //    cout<<result<<'\t'<<rate<<endl;
    //    system("pause");
    }
    return result;
}
int main(){
    Account *p = new Account;
    cin>> p->name >> p->deposit >> p->balanceRate >> p->year;
    (p->balanceRate)/=100;
    double balance = Power(p->deposit,p->balanceRate, p->year);
    cout << p->name << '\t' <<balance;
    cin.get();
    cin.get();
    return 0;
}