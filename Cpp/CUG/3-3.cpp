/*** 
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-16 20:06:34
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-03-16 20:17:41
 * @FilePath: \CUG\3-3.cpp
 * @Description: 
 * @
 * @Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
#include<iostream>
using namespace std;

const int MAXN=1000;
bool Is_prime[MAXN];
int prime[MAXN];

void GeneratePrime(int);

int main(){
    int n;
    cin>>n;
    if (n&1){
        cout<<"Input an integer >2"<<endl;
        return 0;
    }
    GeneratePrime(n);
    for (int i=1; prime[i]<=n/2; i++)
        if (Is_prime[n-prime[i]]){
            cout<<prime[i]<<'+'<<n-prime[i]<<endl;
            break;
        }
    cin.get();
    cin.get();
    return 0;
}

void GeneratePrime(int n){
    for (int i=2; i<=n; i++) Is_prime[i]=true;
    Is_prime[1]=Is_prime[0]=false;
    int num=0;
    for (int i=2; i<=n; i++){
        if (Is_prime[i]==false) continue;
        prime[++num]=i;
        for (int j=2; j<=n/i; j++)
            Is_prime[i*j]=false;
    }
    return;
}