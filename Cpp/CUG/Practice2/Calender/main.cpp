/*** 
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-14 20:47:11
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-03-15 08:23:02
 * @FilePath: \CUG\Practice2\Calender\main.cpp
 * @Description: 
 * @
 * @Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
#include<iostream>
#include "Calender.h"
#include "Calender.cpp"
using namespace std;

int main(){
    int Year,Month,Day=1;
    cout<<"Please input the date in the format'yyyy mm dd' After 2000"<<endl;
    cin>>Year>>Month>>Day;
    bool Flag=Check_Feb(Year)&&(Month==2);
    int Start = QueeryWeekday(6, 20000101, Year,Month);
    Table(Start, Month, Day, Flag);
    cin.get();
    cin.get();
    return 0;
}