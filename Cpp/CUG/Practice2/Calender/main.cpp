/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-14 20:47:11
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-04-06 14:09:59
 * @FilePath: \Calender\main.cpp
 * @Description:
 * @日历计算器,根据2000年1月1日是星期六计算出当月1号是星期几
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#pragma once
#include<iostream>
#include "Calender.h"
#include "Calender.cpp"
using namespace std;

int main(){
    int Year,Month,Day=1;
    cout<<"Please input the date in the format'yyyy mm dd' After 2000"<<endl;
    cin>>Year>>Month>>Day;
    bool Flag=Check_Feb(Year)&&(Month==2);//判断是否为闰年二月
    int Start = QueeryWeekday(6, 20000101, Year,Month);//根据2000年1月1日是星期六计算出当月1号是星期几
    Table(Start, Month, Day, Flag);//打印当前日期所在的月历
    cin.get();
    cin.get();
    return 0;
}