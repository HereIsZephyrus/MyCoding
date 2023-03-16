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

inline bool Is_Bracket(char c){
    return ((c == '(') || (c == ')') || (c == '[') || (c == ']') || (c == '{') || (c == '}'));
}
bool Check_Calc(string expr){
    auto p=expr.begin();
    while (p!=expr.end()){
        if (*p >= '0' && *p <= '9'){
            p++;
            continue;
        }
        if (Is_Bracket(*p)){
            p++;
            continue;
        }
    //    cout << *p << endl;
    //    system("pause");
        if (*p=='*' || *p=='/' || *p=='^'){

            if (p == expr.begin() || p == expr.end() - 1)
                return false;
            char tmp_num = *(p - 1);
            if (!Is_Bracket(tmp_num) && (tmp_num < '0' || tmp_num > '9'))
                return false;
            tmp_num = *(p + 1);
            if (!Is_Bracket(tmp_num) && (tmp_num < '0' || tmp_num > '9'))
                return false;
            p++;
            continue;
        }
        if (*p=='+' || *p=='-'){
            if (p == expr.begin() && p == expr.end() - 1)
                return false;
            char tmp_num = *(p + 1);
            if (!Is_Bracket(tmp_num) && (tmp_num < '0' || tmp_num > '9'))
                return false;
            p++;
            continue;
        }
        if (*p=='!'){
            if (p == expr.begin())
                return false;
            char tmp_num = *(p - 1);
        //    cout<<tmp_num<<endl;
        //    system("pause");
            if (!Is_Bracket(tmp_num) && (tmp_num < '0' || tmp_num > '9'))
                return false;
            p++;
            continue;
        }
        return false;
    }

    return true;
}
bool Check_Bracket(string expr){
    auto p=expr.begin();
    stack<char> Bracket;
    while (p!=expr.end()){
        if (!Is_Bracket(*p)){
            p++;
            continue;
        }
    //    cout<<*p<<endl;
    //    system("pause");
        switch (*p)
        {
        case '(':
            Bracket.push(*p);
            break;
        case '[':
            Bracket.push(*p);
            break;
        case '{':
            Bracket.push(*p);
            break;
        case ')':{
            if (Bracket.empty())   
                return false;
            char tmp_bracket=Bracket.top();
            if (tmp_bracket!='(')
                return false;
            Bracket.pop();
            break;
            }
        case ']':{
            if (Bracket.empty())
                return false;
            char tmp_bracket = Bracket.top();
            if (tmp_bracket != '[')
                return false;
            Bracket.pop();
            break;
            }
        case '}':{
            if (Bracket.empty())
                return false;
            char tmp_bracket = Bracket.top();
            if (tmp_bracket != '{')
                return false;
            Bracket.pop();
            break;
            }
        }
        p++;
    }
    if (Bracket.empty())    return true;
    return false;
}
bool Valid(string expr){
    return (Check_Calc(expr)&&Check_Bracket(expr));
}
long long Factorial(int count){
    long long res=1,tmp_count=count;
    for (int i=count; i; --i)   res*=i;
    return res;
}
long long Fast_Power(long long Base, int Index){
    long long Ans=1,Res=Base;
    for (int b=Index; b; b>>=1,Res*=Res)
        if (b&1)    Ans*=Res;
    return Ans;
}
long long Make(long long a, long long b, char Oper){
    long long Ans=0;
    switch (Oper){
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