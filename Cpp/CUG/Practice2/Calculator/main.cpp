/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-15 22:00:17
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-03-16 12:50:32
 * @FilePath: \CUG\Practice2\Calculator\main.cpp
 * @Description:
 * @将表达式转换为后缀表达式并求解
 * @Copyright (c) 2023 by ${git_name_email}, All Rights Reserved.
 */
#include <iostream>
#include <cstring>
#include <string>
#include <queue>
#include <stack>
#include <map>
#include "Calc.h"
#include "Calc.cpp"
using namespace std;

map<char,int> Priority{{'!',1},{'^',2},{'*',3},{'/',3},{'+',4},{'-',4}};//运算符优先级对应表
string Expr;    //待处理表达式
static int flag=1;//正负号标记
long long Solve(string expr){
    stack<long long> Num;//存储数字
    stack<char> Op;     //存储运算符
//    cout<<"ddd"<<endl;
//    system("pause");
    auto p = expr.begin();
    while (p != expr.end()){//遍历
        //cout<<"ddd "<<*p<<endl;
        if (*p>='0' && *p<='9'){
            long long res=0;
            while (p != expr.end() && (* p >= '0' && *p <= '9')){
                res=res*10+*p-'0';
                p++;
            }//提取数字
        //    cout << res*flag  <<endl;
        //    system("pause");
            Num.push(res*flag);//压入数字栈
            flag=1;
            continue;
        }

        if (Front_Bracket(*p)){
            Op.push(*p);
            p++;
        //    cout<<"front"<<endl;
        //    system("pause");
            continue;
        }

        if (Back_Bracket(*p)){
            while (!Op.empty() && !Front_Bracket(Op.top())){
                //符号栈不为空且栈顶不为左括号
                char top_Op=Op.top();
                Op.pop();
                if (top_Op == '!'){//计算阶乘
                    long long res=Num.top();
                    Num.pop();
                    Num.push(Factorial(res));//压回
                }
                else{//为双目运算符
                    long long a,b;
                    a=Num.top(); Num.pop();//后进入的数
                    b=Num.top(); Num.pop();//先进入的数
                    Num.push(Make(b,a,top_Op));//计算结果并压回栈
                }
            }
            Op.pop();//弹出左括号
            p++;
        //    cout<<"back"<<endl;
        //    system("pause");
            continue;
        }

        if (*p == '-' || *p == '+'){
            if (p==Expr.begin() ||( !Back_Bracket(*(p-1)) && (*(p-1)!='!') && (*(p-1) < '0' || *(p-1) > '9'))){
            //若不是后括号或幂或数字则不是合法双目运算符
                if (*p == '-')  flag=-1;
                if (*p == '+')  flag=1;
                p++;
        //        cout<<"flag"<<endl;
        //        system("pause");
                continue;
            }
        }

        int tmp_Priority =Priority[*p];//得到当前运算符的优先级
        //cout<<Op.top()<<endl;
        //cout << tmp_Priority << endl;
        //system("pause");
        while (!Op.empty() && !Front_Bracket(Op.top())&& Priority[Op.top()]<tmp_Priority){
            //符号栈不为空且栈顶优先级高(小)于当前优先级
            char top_Op=Op.top();//取出栈顶运算符
            Op.pop();
            if (top_Op == '!'){//计算阶乘
                long long res=Num.top();
                Num.pop();
                Num.push(Factorial(res));//压回
            }
            else{//为双目运算符
                long long a,b;
                a=Num.top(); Num.pop();//后进入的数
                b=Num.top(); Num.pop();//先进入的数
                Num.push(Make(b,a,top_Op));
            }
        }
        Op.push(*p);//将当前读取到的运算符压入符号栈
        p++;
    }

    return Num.top();
}
int main(){
    cin>>Expr;
    Expr='('+Expr+')';//在表达式两端加上括号用于简化处理
    if (!Valid(Expr))
        cout<<"It is not a valid expression!"<<endl;
    else
        cout<<Solve(Expr)<<endl;//求解运算符
    cin.get();
    cin.get();
    return 0;
}