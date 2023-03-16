/*** 
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-15 08:28:17
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-03-15 09:15:11
 * @FilePath: \CUG\Practice2\Calculator\Calc.h
 * @Description: 
 * @
 * @Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
#include<iostream>
#include<cstring>
#include<string>
using namespace std;

inline bool Is_Bracket(char c);
bool Check_Calc(string expr);
bool Check_Bracket(string expr);
bool Valid(string expr);
long long Factorial(int count);
long long Fast_Power(long long base,int index);
long long Make(long long a,long long b,char Oper);