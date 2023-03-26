/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-26 17:51:37
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-03-26 18:07:33
 * @FilePath: \Management\Management.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-26 17:51:37
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-03-26 17:53:38
 * @FilePath: \Management\Management.cpp
 * @Description:
 * @
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
            return os;
        }
        istream& read(istream& is)
        {
            float score;
            cin>>this->id>>this->score;
            return is;
        }
        Student operator=(const Student &b){
            this->id=b.id;
            this->score=b.score;
            return *this;
        }
};
Student lib[maxn];

bool checkValid(char c);
char getOperation();
bool Delete(int loc,auto tail);
float QueryMin(auto Begin,auto End);
float QueryMax(auto Begin,auto End);
float QueryAverage(auto Begin,auto End);
float QueryTsquare(auto Begin,auto End);
void Savefile(string Filename,auto Begin,auto End);
Student *Loadfile(string Filename,auto Begin);
void readme();

int main(){
    char operation;
    Student *p = lib;

    readme();
    operation=getOperation();
    while (operation!='X'){
        switch (operation){
            case 'A':{
                cout<<"Please input the ID and score to Add:"<<endl;
                float score;
                p->read(cin);
                cout<<"Add successfully!"<<endl;
                p++;
                break;
            }
            case 'D':{
                cout<<"Please input the ID to Del:"<<endl;
                int loc;
                cin>>loc;
                if (Delete(loc,p))    p--;
                cout<<"Delete successfully!"<<endl;
                break;
            }
            case 'L':{
                cout << "The list is:" << endl;
                for (auto m=lib;m!=p;m++) m->print(cout);
                break;
            }
            case 'M':{
                cout << "The minimum score is " << QueryMin(lib,p) << endl;
                break;
            }
            case 'N':{
                cout << "The average score is " << QueryAverage(lib,p) << endl;
                break;
            }
            case 'P':{
                cout << "The maximum score is " << QueryMax(lib,p) << endl;
                break;
            }
            case 'T':{
                cout << "The standard deviation is " << QueryTsquare(lib,p) << endl;
                break;
            }
            case 'S':{
                string Filename;
                cout << "Please input the filename to save:(including the path and extension)" << endl;
                cin >> Filename;
                Savefile(Filename,lib,p);
                cout<<"Save successfully!"<<endl;
                break;
            }
            case 'O':{
                string Filename;
                cout << "Please input the filename to open:(including the path and extension)" << endl;
                cin >> Filename;
                p=Loadfile(Filename,p);
                cout<<"Load successfully!"<<endl;
                break;
            }
            case 'H':{
                readme();
                break;
            }
            default:{
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

bool checkValid(char c){
    if (c == 'A' || c == 'D' || c == 'L' || c == 'M' || c== 'N' || c=='P' || c=='T' || c=='S' || c=='T' || c=='S' || c=='O' || c=='X' || c=='H') return true;
    if (c == 'a' || c == 'd' || c == 'l' || c == 'm' || c== 'n' || c=='p' || c=='t' || c=='s' || c=='t' || c=='s' || c=='o' || c=='x' || c=='h') return true;
    return false;
}
char getOperation(){
    char operation;
    cin.get(operation);
    while (!checkValid(operation))
        cin.get(operation);
    return toupper(operation);
}
bool Delete(int loc,auto tail){
    auto m = lib;
    while (m->id!=loc)    m++;
    if (m-1==tail){
        cout << "No such ID!" << endl;
        return false;
    }
    for ( ;m!=tail;m++)    *m=*(m+1);
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
    float average = QueryAverage(Begin,End);
    for (auto m=Begin;m!=End;m++)
        sum += (m->getScore()-average)*(m->getScore()-average);
    return sqrt(sum/(End-Begin));
}
void Savefile(string Filename,auto Begin,auto End){
    ofstream fout(Filename);
    for (auto m=Begin;m!=End;m++)
        m->print(fout);
    fout.close();
}
Student *Loadfile(string Filename,auto Begin){
    ifstream fin(Filename);
    auto m=Begin;
    while (!fin.eof())
        (++m)->read(fin);
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