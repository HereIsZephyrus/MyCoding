/*** 
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-15 22:00:17
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-03-16 12:50:32
 * @FilePath: \CUG\Practice2\Calculator\main.cpp
 * @Description: 
 * @
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

map<char,int> Priority{{'}',1},{']',1},{')',1},{'!',2},{'^',3},{'*',4},{'/',4},{'+',5},{'-',5}};
string Expr;
long long Solve(string expr){
    // Convert to a suffix expression and solve for it
    stack<long long> Num;
    stack<char> Op;
//    cout<<"ddd"<<endl;
//    system("pause");
    auto p = expr.begin();
    while (p != expr.end()){
        if (*p>='0' && *p<='9'){
            long long res=0;
            while (p != expr.end() && * p >= '0' && *p <= '9'){
                res=res*10+*p-'0';
                p++;
            }
//            cout << res << endl;
//            system("pause");
            Num.push(res);
        }
        else{
            if (*p == '(' || *p == '[' || * p == '{'){
                Op.push(*p);
                p++;
                continue;
            }
            int tmp_Priority =Priority[*p];
            //cout << tmp_Priority << endl;
            //system("pause");
            while (!Op.empty() && !Is_Bracket(Op.top()) &&Priority[Op.top()]<tmp_Priority){//op in stack < pre then calc
                char top_Op=Op.top();
                Op.pop();
                if (top_Op == '!'){
                    long long res=Num.top();
                    Num.pop();
                    Num.push(Factorial(res));
                }
                else{
                    long long a,b;
                    a=Num.top(); Num.pop();//the back
                    b=Num.top(); Num.pop();//the front
                    Num.push(Make(b,a,top_Op));
                }
            }
            if (Is_Bracket(*p)){
                while (!Op.empty() && !Is_Bracket(Op.top()) && Priority[Op.top()] < tmp_Priority)
                { // op in stack < pre then calc
                    Op.pop();
                }
            else
                Op.push(*p);
            p++;
        }
    }
    cout << Op.size() << endl;
//    system("pause");
    while (!Op.empty()){
        char top_Op = Op.top();
        Op.pop();
        cout << Op.top() << endl;
        system("pause");
        if (Is_Bracket(top_Op)) continue;
        if (top_Op == '!'){
            long long res = Num.top();
    //        cout << Num.top() << endl;
    //        system("pause");
            Num.pop();
            Num.push(Factorial(res));
    //        cout<<Num.top()<<endl;
    //        system("pause");
        }
        else{
            long long a, b;
            a = Num.top();    Num.pop(); // the back
            b = Num.top();    Num.pop(); // the front
            cout << a<<' '<<b << endl;
            system("pause");
            Num.push(Make(b, a, top_Op));
        }
    }
    return Num.top();
}
int main(){
    cin>>Expr;
    if (!Valid(Expr))
        cout<<"It is not a valid expression!"<<endl;
    else
        cout<<Solve(Expr)<<endl;
    cin.get();
    cin.get();
    return 0;
}