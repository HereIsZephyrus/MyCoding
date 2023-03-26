/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-15 08:28:17
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-03-26 14:28:47
 * @FilePath: \Homeworkc:\Users\Administrator\GitHub\MyCoding\Cpp\CUG\Practice2\Calculator\Calc.h
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#include<iostream>
#include<cstring>
#include<string>
using namespace std;

inline bool Front_Bracket(char c);
inline bool Back_Bracket(char c);
inline bool Is_Bracket(char c);
bool Check_Calc(string expr);
bool Check_Bracket(string expr);
bool Valid(string expr);
long long Factorial(int count);
long long Fast_Power(long long base,int index);
long long Make(long long a,long long b,char Oper);