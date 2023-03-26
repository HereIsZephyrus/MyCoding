/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-15 08:33:53
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-03-15 23:25:22
 * @FilePath: \CUG\Practice2\Calculator\Calc.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ${git_name_email}, All Rights Reserved.
 */
#include<iostream>
#include<cstring>
#include<string>
#include<queue>
#include<stack>
#include "Calc.h"
using namespace std;

inline bool Front_Bracket(char c){//判断是否为前括号
    return ((c == '(') || (c == '[') || (c == '{'));
}
inline bool Back_Bracket(char c){//判断是否为后括号
    return ((c == ')') || (c == ']') || (c == '}'));
}
inline bool Is_Bracket(char c){//判断是否为括号
    return (Front_Bracket(c) || Back_Bracket(c));
}
bool Check_Calc(string expr){//检查运算符是否合法
    auto p=expr.begin();
    while (p!=expr.end()){
        if (*p >= '0' && *p <= '9'){
            p++;
            continue;
        }//跳过数字
        if (Is_Bracket(*p)){
            p++;
            continue;
        }//跳过括号
    //    cout << *p << endl;
    //    system("pause");
        if (*p=='*' || *p=='/' || *p=='^'){//检查乘除幂是否合法

            if (p == expr.begin() || p == expr.end() - 1)
                return false;//若为第一个或者最后一个则不合法
            char tmp_num = *(p - 1);//查看前一个字符是否合法
            if (!Back_Bracket(tmp_num) && (tmp_num!='!')&&(tmp_num < '0' || tmp_num > '9'))
                return false;//若不是后括号或幂或数字则不合法
            tmp_num = *(p + 1);//查看后一个字符是否合法
            if (!Is_Bracket(tmp_num) && (tmp_num < '0' || tmp_num > '9'))
                return false;//若不是前括号或数字则不合法
            p++;
            continue;
        }
        if (*p=='+' || *p=='-'){//检查加减是否合法,其中标识符号时为单目运算符
            if (p == expr.end() - 1)
                return false;//若为最后一个则不合法
            char tmp_num = *(p - 1);//查看前一个字符是否合法
            if (!Back_Bracket(tmp_num)  && (tmp_num!='!') && (tmp_num < '0' || tmp_num > '9')){
                //若不是后括号或幂或数字则不合法
                tmp_num = *(p + 1);//查看后一个字符是否合法
                if (tmp_num < '0' || tmp_num > '9')
                    return false;//若不是数字则不合法
            }
            tmp_num = *(p + 1);//查看后一个字符是否合法
            if (!Is_Bracket(tmp_num) && (tmp_num < '0' || tmp_num > '9'))
                return false;//若不是前括号或数字则不合法
            p++;
            continue;
        }
        if (*p=='!'){//检查阶乘是否合法
            if (p == expr.begin())
                return false;//若为第一个则不合法
            char tmp_num = *(p - 1);//查看前一个字符是否合法
        //    cout<<tmp_num<<endl;
        //    system("pause");
            if (!Back_Bracket(tmp_num) && (tmp_num < '0' || tmp_num > '9'))
                return false;//若不是后括号或数字则不合法
            p++;
            continue;
        }
        return false;
    }

    return true;
}
bool Check_Bracket(string expr){//检查括号配对是否合法
    auto p=expr.begin();
    stack<char> Bracket;//括号栈
    while (p!=expr.end()){
        if (!Is_Bracket(*p)){
            p++;
            continue;
        }//跳过非括号
    //    cout<<*p<<endl;
    //    system("pause");
        if (Front_Bracket(*p)){
            Bracket.push(*p);
            p++;
            continue;
        }//若为前括号则入栈
        switch (*p){//若为后括号则出栈并判断是否匹配
        case ')':{
            if (Bracket.empty())
                return false;//若栈为空则说明不合法
            char tmp_bracket=Bracket.top();
            if (tmp_bracket!='(')
                return false;//括号类型不匹配
            Bracket.pop();
            break;
            }
        case ']':{
            if (Bracket.empty())
                return false;//若栈为空则说明不合法
            char tmp_bracket = Bracket.top();
            if (tmp_bracket != '[')
                return false;//括号类型不匹配
            Bracket.pop();
            break;
            }
        case '}':{
            if (Bracket.empty())
                return false;//若栈为空则说明不合法
            char tmp_bracket = Bracket.top();
            if (tmp_bracket != '{')
                return false;//括号类型不匹配
            Bracket.pop();
            break;
            }
        }
        p++;
    }
    if (Bracket.empty())    return true;
    return false;//若栈不为空则说明有未匹配的前括号
}
bool Valid(string expr){//表达式合法即运算符与括号都合法
    return (Check_Calc(expr)&&Check_Bracket(expr));
}
long long Factorial(int count){
    long long res=1,tmp_count=count;
    for (int i=count; i; --i)   res*=i;
    return res;
}//阶乘运算
long long Fast_Power(long long Base, int Index){
    long long Ans=1,Res=Base;
    for (int b=Index; b; b>>=1,Res*=Res)
        if (b&1)    Ans*=Res;
    return Ans;
}//幂运算(快速幂)
long long Make(long long a, long long b, char Oper){
    long long Ans=0;
    switch (Oper){//根据运算符进行运算(双目运算符)
    case '+':
        return a + b;
    case '-':
        return a - b;
    case '*':
        return a * b;
    case '/':
        return a / b;
    case '^':
        return Fast_Power(a,b);
    }
}