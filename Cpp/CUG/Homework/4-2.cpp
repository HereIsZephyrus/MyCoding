/*** 
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-25 20:25:20
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-03-26 13:11:45
 * @FilePath: \undefinedc:\Users\Administrator\GitHub\MyCoding\Cpp\CUG\Homework\4-2.cpp
 * @Description: 
 * @
 * @Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
#include<iostream>
#include<cstring>
#include<string>
using namespace std;
 
const int maxn = 100;
class Person{
    string name,adress;
    void clear(){name.clear(); adress.clear();}
    public:
        Person(){};
        Person(string n, string a):name(n), adress(a){}
        void display(){cout << name <<'\t'<<adress<< endl;}
        istream& read(istream& is = cin)
        {
            char c;
            is.get(c);
            while (c<48) is.get(c);
            is >> name >> adress;
            name=c+name;
            return is;
        } 
};
void readme(){
    cout << "A [name] [address] - Add one person" << endl;
    cout << "D [ID] - Del one person" << endl;
    cout << "M [ID] [name] [address] - Modi ID's person base 1" << endl;
    cout << "C - clear all the person" << endl;
    cout << "L - list the person" << endl;
    cout << "X - Exit" << endl;
    cout << "H - help" << endl;
}
bool checkValid(char c){
    if (c == 'A' || c == 'M' || c == 'M' || c == 'C' || c== 'L' || c=='X' || c=='H' || c=='D') return true;
    if (c == 'a' || c == 'm' || c == 'm' || c == 'c' || c== 'l' || c=='x' || c=='h' || c=='d') return true;
    return false;
}
int main(){
    Person Contacts[maxn];
    char operation;
    Person *p = Contacts;
    readme();
    cin.get(operation);
    while (!checkValid(operation))  
        cin.get(operation);
    operation=toupper(operation);
    while (operation != 'X'){
        switch (operation){
            case 'A':{
                p->read();
                p++;
                cout << "add finished" << endl;
                break;
            }
            case 'M':{
                int loc;
                cin >> loc;
                Contacts[loc-1].read();
                cout <<loc<<" is modified" << endl;
                break;
            }
            case 'C':{
                p=Contacts;
                cout<<"clear all";
                break;
            }
            case 'L':{
                for (int i = 0; i < p-Contacts; i++)
                    Contacts[i].display();
                break;
            }
            case 'D':{
                int loc;
                cin >> loc;
                for (int i = loc-1; i < p-Contacts; i++)
                    Contacts[i] = Contacts[i+1];
                p--;
                cout << loc << " is deleted" << endl;
                break;
            }
            case 'H':{
                readme();
                break;
            }
        }
        cin.get(operation);
        while (!checkValid(operation))
            cin.get(operation);
        operation = toupper(operation);
    }
    return 0;
}