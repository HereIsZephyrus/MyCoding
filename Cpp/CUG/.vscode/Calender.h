/*** 
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-14 19:42:19
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-03-14 19:50:10
 * @FilePath: \CUG\.vscode\Calender.h
 * @Description: 
 * @To Seek the day
 * @To generate the table based on the true time;
 * @Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
#include<iostream>
using namespace std;

pair<int, int> QueeryWeekday(const int Raw_Week, const int Raw_date, int Current_date);
void Table(int Weekday_First,int Month,int CurrentDay);