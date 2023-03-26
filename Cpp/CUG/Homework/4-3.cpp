/*** 
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-25 21:49:34
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-03-25 21:53:17
 * @FilePath: \undefinedc:\Users\Administrator\GitHub\MyCoding\Cpp\CUG\Homework\4-3.cpp
 * @Description: 
 * @
 * @Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
#include<iostream>
#include<cstring>
#include<iomanip>
using namespace std;

const int Monthday[12]{31,28,31,30,31,30,31,31,30,31,30,31};
const string Weekday[7]{"Sun","Mon","Tue","Wed","Thr","Fri","Sat"};
int start_year,start_month,start_day,end_year,end_month,end_day;
int n;

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
void init(){
    string StartDate;
    cin >> StartDate >> n;
    start_year = (StartDate[0]-'0')*1000 + (StartDate[1]-'0')*100 + (StartDate[2]-'0')*10 + (StartDate[3]-'0');
    start_month = (StartDate[4]-'0')*10 + (StartDate[5]-'0');
    start_day = (StartDate[6]-'0')*10 + (StartDate[7]-'0');
    return;
}
void solve(){
    int year=start_year,month=start_month,day=start_day;
    while (n>Monthday[month-1]){
        n-=Monthday[month-1];
        if (month==2 && Check_Feb(year))    n--;
        month++;
        if (month>12){
            month=1;
            year++;
        }
    }
    while (n){
        n--;
        day++;
        if (day>Monthday[month-1]){
            day=1;
            month++;
            if (month>12){
                month=1;
                year++;
            }
        }
    }
    end_year=year;
    end_month=month;
    end_day=day;
    return;
}
void print(){
    if (end_year>=10000)
        cout<<"out of limitation!";
    else
        cout<<setfill('0')<<setw(4)<<end_year<<setfill('0')<<setw(2)<<end_month<<setfill('0')<<setw(2)<<end_day<<endl;
    return;
}
int main(){
    init();
    solve();
    print();
    cin.get();
    cin.get();
    return 0;
}