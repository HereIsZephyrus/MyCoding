/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-26 17:51:37
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-03-26 17:53:38
 * @FilePath: \Management\Management.cpp
 * @Description:
 * @数据库管理系统
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#include<iostream>
#include<fstream>
#include<cstring>
#include<string>
#include<cstdio>
#include<cmath>
using namespace std;

const int maxn = 10000;
const float INF = 0xFFFF;
class Student{
    float score;
    public:
        int id;
        Student(int id=0,float score=0):id(id),score(score){}
        float getScore(){return score;}
        ostream& print(ostream& os){
            os << "ID: " << id << "\tScore: " << score<<endl;
            return os;//输出流
        }
        istream& read(istream& is)
        {
            float score;
            cin>>this->id>>this->score;
            return is;//输入流
        }
        Student operator=(const Student &b){//重载赋值
            this->id=b.id;
            this->score=b.score;
            return *this;
        }
};
Student lib[maxn];

bool checkValid(char c);//检查输入是否为合法操作符
char getOperation();//获取操作符,跳过空字符与非法操作符
bool Delete(int loc,auto tail);//删除指定位置的元素,成功返回true,失败返回false
float QueryMin(auto Begin,auto End);//查询最小值
float QueryMax(auto Begin,auto End);//查询最大值
float QueryAverage(auto Begin,auto End);//查询平均值
float QueryTsquare(auto Begin,auto End);//查询方差
void Savefile(string Filename,auto Begin,auto End);//保存数组内容至指定文件
Student *Loadfile(string Filename,auto Begin);//从文件流读取信息
void readme();

int main(){
    char operation;
    Student *p = lib;

    readme();//显示合法操作符信息
    operation=getOperation();
    while (operation!='X'){//若要求不为退出
        switch (operation){
            case 'A':{//添加
                cout<<"Please input the ID and score to Add:"<<endl;
                float score;
                p->read(cin);//从标准流读取信息
                cout<<"Add successfully!"<<endl;
                p++;//指针后移
                break;
            }
            case 'D':{//删除
                cout<<"Please input the ID to Del:"<<endl;
                int loc;
                cin>>loc;
                if (Delete(loc,p))    p--;//若删除成功则指针回退
                else    cout<<"Delete failed!"<<endl;
                cout<<"Delete successfully!"<<endl;
                break;
            }
            case 'L':{//列出数据库信息
                cout << "The list is:" << endl;
                for (auto m=lib;m!=p;m++) m->print(cout);//将信息输出至标准流
                break;
            }
            case 'M':{//查询最小值
                cout << "The minimum score is " << QueryMin(lib,p) << endl;
                break;
            }
            case 'N':{//查询平均值
                cout << "The average score is " << QueryAverage(lib,p) << endl;
                break;
            }
            case 'P':{//查询最大值
                cout << "The maximum score is " << QueryMax(lib,p) << endl;
                break;
            }
            case 'T':{//查询方差
                cout << "The standard deviation is " << QueryTsquare(lib,p) << endl;
                break;
            }
            case 'S':{//保存数组内容至指定文件
                string Filename;
                cout << "Please input the filename to save:(including the path and extension)" << endl;
                cin >> Filename;
                Savefile(Filename,lib,p);
                cout<<"Save successfully!"<<endl;
                break;
            }
            case 'O':{//从指定文件读取内容添加
                string Filename;
                cout << "Please input the filename to open:(including the path and extension)" << endl;
                cin >> Filename;
                p=Loadfile(Filename,p);
                cout<<"Load successfully!"<<endl;
                break;
            }
            case 'H':{//显示帮助文档
                readme();
                break;
            }
            default:{//非法操作符(但并不会被触发)
                cout << "Invalid operation!" << endl;
                break;
            }
        }
        operation=getOperation();
    }
    cin.get();
    cin.get();
    return 0;
}

bool checkValid(char c){//检查输入是否为合法操作符
    if (c == 'A' || c == 'D' || c == 'L' || c == 'M' || c== 'N' || c=='P' || c=='T' || c=='S' || c=='T' || c=='S' || c=='O' || c=='X' || c=='H') return true;
    if (c == 'a' || c == 'd' || c == 'l' || c == 'm' || c== 'n' || c=='p' || c=='t' || c=='s' || c=='t' || c=='s' || c=='o' || c=='x' || c=='h') return true;
    return false;
}
char getOperation(){//获取操作符,跳过空字符与非法操作符
    char operation;
    cin.get(operation);
    while (!checkValid(operation))
        cin.get(operation);
    return toupper(operation);
}
bool Delete(int loc,auto tail){
    auto m = lib;
    while (m->id!=loc)    m++;
    if (m-1==tail){//若未找到
        cout << "No such ID!" << endl;
        return false;
    }
    for ( ;m!=tail;m++)    *m=*(m+1);//将后面的元素前移
    return true;
}
float QueryMin(auto Begin,auto End){
    float Min = INF;
    for (auto m=Begin;m!=End;m++)
        if (m->getScore()<Min) Min = m->getScore();
    return Min;
}
float QueryMax(auto Begin,auto End){
    float Max = 0;
    for (auto m=Begin;m!=End;m++)
        if (m->getScore()>Max) Max = m->getScore();
    return Max;
}
float QueryAverage(auto Begin,auto End){
    float sum = 0;
    for (auto m=Begin;m!=End;m++)
        sum += m->getScore();
    return sum/(End-Begin);
}
float QueryTsquare(auto Begin,auto End){
    float sum = 0;
    float average = QueryAverage(Begin,End);//计算平均值
    for (auto m=Begin;m!=End;m++)
        sum += (m->getScore()-average)*(m->getScore()-average); //计算方差
    return sqrt(sum/(End-Begin));
}
void Savefile(string Filename,auto Begin,auto End){
    ofstream fout(Filename);
    for (auto m=Begin;m!=End;m++)
        m->print(fout);//将信息输出至文件流
    fout.close();
}
Student *Loadfile(string Filename,auto Begin){
    ifstream fin(Filename);
    auto m=Begin;
    while (!fin.eof())
        (++m)->read(fin);//从文件流读取信息
    fin.close();
    return m;
}

void readme(){
    cout << "The followed operation are available:"<<endl;
    cout << "A - Add a score" << endl;
    cout << "D - Del a score" << endl;
    cout << "L - List All scores and count" << endl;
    cout << "M - Minimum of scores" << endl;
    cout << "N - Average of scores" << endl;
    cout << "P - Maximum of scores" << endl;
    cout << "T - Standard derivation of scores" << endl;
    cout << "S - Save scores to file" << endl;
    cout << "O - Open scores from file" << endl;
    cout << "X - Exit" << endl;
    cout << "H - Help" << endl;
}