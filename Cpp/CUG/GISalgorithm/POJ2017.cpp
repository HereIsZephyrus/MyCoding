/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2024-05-30 15:40:00
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2024-05-30 20:10:43
 * @FilePath: \GISalgorithm\POJ2017.cpp
 * @Description:
 * @
 * @Copyright (c) 2024 by ChanningTong, All Rights Reserved.
 */
#include<iostream>
int main(){
    int n;
    std::cin>>n;
    while(n != -1){
        int total = 0,standHour = 0;
        while (n--){
            int speed,cumHour;
            std::cin>>speed>>cumHour;
            total += speed * (cumHour - standHour);
            standHour = cumHour;
        }
        std::cout<<total<<" miles"<<std::endl;
        std::cin>>n;
    }
    return 0;
}