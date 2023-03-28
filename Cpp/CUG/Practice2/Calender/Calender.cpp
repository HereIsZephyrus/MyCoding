/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-14 19:52:37
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-03-28 18:32:49
 * @FilePath: \Managementc:\Users\Administrator\GitHub\MyCoding\Cpp\CUG\Practice2\Calender\Calender.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#include "Calender.h"
#include<iostream>
#include<cstring>
#include<iomanip>
using namespace std;

const int Monthday[12]{31,28,31,30,31,30,31,31,30,31,30,31};//记录月份的天数
const string Weekday[7]{"Sun","Mon","Tue","Wed","Thr","Fri","Sat"};//记录星期的英文缩写用于打印

bool Check_Feb(int year){//判断是否为闰年
    if ((year%4==0 && year%100!=0) || (year%400==0))    return true;
    return false;
}

int QueeryWeekday(const int Raw_Week, const int Raw_date,int Current_year,int Current_Month)//查询某一天是星期几
{
    int Weekday=Raw_Week,Raw_year=Raw_date/10000;//初始化为起始年份和日期
    for (int Year=Raw_year; Year<Current_year; ++Year)//计算上一年的1月1日的星期数
        Weekday = (Weekday + (365 + Check_Feb(Year)) % 7) % 7; //weekday=0为Sunday
    for (int Month=1; Month<Current_Month; ++Month){
        if (Month==2)//如果是二月份闰月要多加一天
            Weekday = (Weekday + (Monthday[Month-1] + Check_Feb(Current_year)) % 7) % 7;
        else
            Weekday = (Weekday + Monthday[Month-1] % 7) % 7;
    }
    return Weekday;
}
void Table(int Weekday_First,int Month,int CurrentDay,bool Febflag){
    for (int i=0; i<30; ++i)    cout<<"-";//上边框
    cout<<endl<<'|';//左边框
    for (int i=0; i<7; ++i)     cout<<Weekday[i]<<' ';//打印星期数名称
    cout<<'|'<<endl;//右边框
    int List=1,Len=Monthday[Month-1],p=Weekday_First;
    //List为打印日期数，Len为当前月份的天数，p为当前月1月1日星期数
    cout<<'|';
    for (int i=0; i<Weekday_First; ++i) cout<<"    ";
    if (Febflag)    ++Len;//如果是闰年二月份多一天
    while (List<=Len){
        if (List==CurrentDay)//如果是当前日期则加上*
            cout <<'*'<< setw(2) << List++<<'*';
        else
            cout << setw(3) << List++<<' ';
        if (++p %7==0)  cout<<'|'<<endl<<'|';//每打印7天换行
    }
    for (int i = p%7; i < 7; ++i)     cout << "    ";
    cout<<'|'<<endl;
    for (int i = 0; i < 30; ++i)    cout << "-";//下边框
    return;
}
