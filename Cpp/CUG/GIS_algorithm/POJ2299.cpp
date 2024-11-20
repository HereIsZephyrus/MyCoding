/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2024-05-30 15:40:00
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2024-05-30 20:31:48
 * @FilePath: \GISalgorithm\POJ2299.cpp
 * @Description:
 * @
 * @Copyright (c) 2024 by ChanningTong, All Rights Reserved.
 */
#include<iostream>
#include<vector>
#define ull unsigned long long

ull msort(int left,int right,std::vector<int>& value){
    if(left>=right)    return 0;
    int mid = left + (right - left) / 2;
    ull count = msort(left, mid, value) + msort(mid + 1, right, value);
    int i = left, j = mid + 1, k = 0;
    std::vector<int> temp(right-left+1);
    while(i <= mid && j <= right)
    	if(value[i]<=value[j])
    		temp[k++]=value[i++];
    	else{
    		temp[k++]=value[j++];
            count += (mid-i+1);
        }
    while(i<=mid)	temp[k++]=value[i++];
    while(j<=right)	temp[k++]=value[j++];
    for (int i = left; i <= right; i++)
        value[i] = temp[i-left];
    return count;
}
int main(){
    int n;
    while (std::cin>>n){
        if (n==0)    break;
        std::vector<int> value(n);
        for (int i = 0; i < n; i++)
            std::cin>>value[i];
        std::cout<<msort(0,n-1,value)<<std::endl;
    }
    return 0;
}