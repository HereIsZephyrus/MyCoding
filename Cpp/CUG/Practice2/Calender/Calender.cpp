/*** 
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-14 19:52:37
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-03-15 08:04:55
 * @FilePath: \CUG\Practice2\Calender\Calender.cpp
 * @Description: 
 * @
 * @Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
#include "Calender.h"
#include<iostream>
#include<cstring>
#include<iomanip>
using namespace std;

const int Monthday[12]{31,28,31,30,31,30,31,31,30,31,30,31};
const string Weekday[7]{"Sun","Mon","Tue","Wed","Thr","Fri","Sat"};

bool Check_Feb(int year){
    if ((year%4==0 && year%100!=0) || (year%400==0))    return true;
    return false;
}

int QueeryWeekday(const int Raw_Week, const int Raw_date,int Current_year,int Current_Month)
{
    int Weekday=Raw_Week,Raw_year=Raw_date/10000;
    for (int Year=Raw_year; Year<Current_year; ++Year)
        Weekday = (Weekday + (365 + Check_Feb(Year)) % 7) % 7; //weekday=0:Sunday
    for (int Month=1; Month<Current_Month; ++Month){
        if (Month==2)
            Weekday = (Weekday + (Monthday[Month-1] + Check_Feb(Current_year)) % 7) % 7;
        else
            Weekday = (Weekday + Monthday[Month-1] % 7) % 7;
        //Weekday=(Weekday+1)%7;//The Current Month is the pre+1;
    }
    return Weekday;
}
void Table(int Weekday_First,int Month,int CurrentDay,bool Febflag){
    for (int i=0; i<30; ++i)    cout<<"-";
    cout<<endl<<'|';
    for (int i=0; i<7; ++i)     cout<<Weekday[i]<<' ';
    cout<<'|'<<endl;
    int List=1,Len=Monthday[Month-1],p=Weekday_First;
    cout<<'|';
    for (int i=0; i<Weekday_First; ++i) cout<<"    ";
    if (Febflag)    ++Len;
    while (List<=Len){
        if (List==CurrentDay)
            cout <<'*'<< setw(2) << List++<<'*';
        else
            cout << setw(3) << List++<<' ';
        if (++p %7==0)  cout<<'|'<<endl<<'|';
    }
    for (int i = p%7; i < 7; ++i)     cout << "    ";
    cout<<'|'<<endl;
    for (int i = 0; i < 30; ++i)    cout << "-";
    return;
}
