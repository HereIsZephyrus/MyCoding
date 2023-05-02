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
#include<vector>
using namespace std;

const float INF = 0xFFFF;
class Student{
    float score;
    public:
        int id;
        Student(int id=0,float score=0):id(id),score(score){}
        float getScore(){return score;}
        ostream& print(ostream& os) const{
            os << "ID: " << id << "\tScore: " << score<<endl;
            return os;//输出流
        }
        istream& read(istream& is){
            is>>this->id>>this->score;
            return is;//输入流
        }
        friend ifstream& operator>>(ifstream& is,Student& b){
            is>>b.id>>b.score;
            return is;
        }
        Student operator=(const Student &b){//重载赋值
            this->id=b.id;
            this->score=b.score;
            return *this;
        }
};
std::vector<Student> lib;
bool checkValid(char c);//检查输入是否为合法操作符
char getOperation();//获取操作符,跳过空字符与非法操作符
bool Delete(int loc);//删除指定位置的元素,成功返回true,失败返回false
float QueryMin();//查询最小值
float QueryMax();//查询最大值
float QueryAverage();//查询平均值
float QueryTsquare();//查询方差
void Savefile(string Filename);//保存数组内容至指定文件
void Loadfile(string Filename);         // 从文件流读取信息
void readme();

int main(){
    char operation;
    std::vector<Student>::iterator p = lib.begin();

    readme();//显示合法操作符信息
    operation=getOperation();
    while (operation!='X'){//若要求不为退出
        switch (operation){
            case 'A':{//添加
                cout<<"Please input the ID and score to Add:"<<endl;
                Student temp;
                temp.Student::read(cin);//从标准流读取信息
                lib.push_back(temp);//从标准流读取信息
                cout<<"Add successfully!"<<endl;
                //++p;//指针后移
                break;
            }
            case 'D':{//删除
                cout<<"Please input the ID to Del:"<<endl;
                int loc;
                cin>>loc;
                if (!Delete(loc))
                    cout<<"Delete failed!"<<endl;
                else
                    cout<<"Delete successfully!"<<endl;
                break;
            }
            case 'L':{//列出数据库信息
                cout << "The list is:" << endl;
                for (std::vector<Student>::iterator m=lib.begin();m!=lib.end();++m) (*m).Student::print(cout);//将信息输出至标准流
                break;
            }
            case 'M':{//查询最小值
                cout << "The minimum score is " << QueryMin() << endl;
                break;
            }
            case 'N':{//查询平均值
                cout << "The average score is " << QueryAverage() << endl;
                break;
            }
            case 'P':{//查询最大值
                cout << "The maximum score is " << QueryMax() << endl;
                break;
            }
            case 'T':{//查询方差
                cout << "The standard deviation is " << QueryTsquare() << endl;
                break;
            }
            case 'S':{//保存数组内容至指定文件
                string Filename;
                cout << "Please input the filename to save:(including the path and extension)" << endl;
                cin >> Filename;
                Savefile(Filename);
                cout<<"Save successfully!"<<endl;
                break;
            }
            case 'O':{//从指定文件读取内容添加
                string Filename;
                cout << "Please input the filename to open:(including the path and extension)" << endl;
                cin >> Filename;
                Loadfile(Filename);
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
bool Delete(int loc){
    for (std::vector<Student>::const_iterator m = lib.begin(); m!=lib.end(); ++m)
        if ((*m).id == loc){
            lib.erase(m);
            return true;
        }
    return false;
}
float QueryMin(){
    float Min = INF;
    for (std::vector<Student>::iterator m=lib.begin();m!=lib.end();++m)
        if (m->getScore()<Min) Min = m->getScore();
    return Min;
}
float QueryMax(){
    float Max = 0;
    for (std::vector<Student>::iterator m=lib.begin();m!=lib.end();++m)
        if (m->getScore()>Max) Max = m->getScore();
    return Max;
}
float QueryAverage(){
    float sum = 0;
    for (std::vector<Student>::iterator m=lib.begin();m!=lib.end();++m)
        sum += m->getScore();
    return sum/(lib.end()-lib.begin());
}
float QueryTsquare(){
    float sum = 0;
    float average = QueryAverage();//计算平均值
    for (std::vector<Student>::iterator m=lib.begin();m!=lib.end();++m)
        sum += (m->getScore()-average)*(m->getScore()-average); //计算方差
    return sqrt(sum/(lib.end()-lib.begin()));
}
void Savefile(string Filename){
    ofstream fout;
    fout.open(Filename);
    for (std::vector<Student>::iterator m=lib.begin();m!=lib.end();++m)
        m->print(fout);//将信息输出至文件流
    fout.close();
    return;
}
void Loadfile(string Filename){
    ifstream fin;
    fin.open(Filename);
    do {
        Student temp;
        temp.Student::read(fin);
        if (fin.eof()) break;
        temp.print(cout);
        lib.push_back(temp);
    }while (!fin.eof());
    fin.close();
    return;
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