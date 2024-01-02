/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-12-29 20:11:27
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-12-29 20:11:34
 * @FilePath: \AIfoundation\digit.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#include "digit.h"
#include<fstream>
using std::cin;
using std::cout;
using std::endl;
using std::make_pair;
using std::getline;

static int num=0;
int FatherID[MAXN];
int main()
{
    for (int i=0; i<MAXN; ++i)  FatherID[i]=0;
    freopen("Input.txt","r",stdin);
    //std::priority_queue<Node, std::vector<Node>, cmp> q; // search queue
    std::priority_queue<Node> q;
    std::set<Matrix> s;                                              // path storage
    Matrix mapping;
    cin>>mapping;
    q.push({mapping,0,++num});
    s.insert(q.top().map);
    while (!q.empty())
    {
        auto x = q.top();
        Print(&x.map,x.id);
        const int t=x.deep,fid=x.id;
        Matrix* map=&x.map;
        map->CalcH();//ugly!!!!!!!!!!!!!!!!!!!!!! but why QAQ
        //cout<<"now:"<<endl<<*map<<endl;
        q.pop();
        if (map->getH() == 0) // Solve it!
        {
            cout << "The step counts " << t<< endl<<*map;
            system("pause");
            return 0;
        }
        Search(&q,&s,map,t,fid);
    }
    return 0;
}

void Matrix::Init()
{
    std::vector<int> goal,puzzle;
    cout << "Please input the initial state:"<<endl;
    int len=n*n,d;
    for (int i = 0; i < len; ++i)
    {
        cin >> d;
        puzzle.push_back(d);
    }
    cout << "Please input the orient state:"<<endl;
    for (int i = 0; i < len; ++i)
    {
        cin >> d;
        goal.push_back(d);
    }
    build(n,puzzle,goal);
    return;
}

void Matrix::CalcH()
{
    int res=0;
    for (int i=0; i<n; ++i)
        for (int j=0; j<n; ++j)
            if (num[i][j]!= term[i][j])
                res++;
    h=res;
    //return res;
}
int Matrix::countInverse(const std::vector<int> &a)
{
    int counting=0;
    size_t len=a.size();
    for (int i=0; i<len-1; ++i)
        for (int j=i+1; j<len; ++j)
            counting+=a[i]&&a[j]&&(a[i]-a[j]);
    return counting;
}

std::string Matrix::checkValid(const std::vector<int> &puzzle, const std::vector<int> &goal)
{
    std::string state;
    // xor<puzzle,goal>=1 means their parities are diffience.
    reachable = ~(countInverse(puzzle) ^ countInverse(goal)) & 1;
    if (reachable)
        state="The state is reachable!";
    else
        state="The state isn't reachable!";
    return state;
}

void Matrix::build(size_t size, const std::vector<int> &puzzle, const std::vector<int> &goal)
{
    n = size;
    cout << checkValid(puzzle, goal)<<endl;
    for (int i = 0; i < n; ++i)
    {
        std::vector<int> tmp_puzzle,tmp_goal;
        for (int j = 0; j < n; ++j)
        {
            tmp_puzzle.push_back(puzzle[i * n + j]);
            tmp_goal.push_back(goal[i*n+j]);
        }
        num.push_back(tmp_puzzle);
        term.push_back(tmp_goal);
    }
    CalcH();
}

std::pair<int,int> Matrix::getZ()
{
    std::pair<int,int> res;
    for (std::vector<std::vector<int>>::iterator itx = num.begin(); itx != num.end(); ++itx)
    {
        std::vector<int> x = *itx;
        for (std::vector<int>::iterator ity = x.begin(); ity != x.end(); ++ity)
            if ((*ity)==0)
                res = make_pair(static_cast<int>(itx-num.begin()),static_cast<int>(ity-x.begin()));
    }
    return res;
}

void Search(std::priority_queue<Node> *q, std::set<Matrix> *s, Matrix *map, const int t, const int fid)
{
    const int dx[4] = {1, -1, 0, 0}, dy[4] = {0, 0, 1, -1};
    std::pair<int, int> LZ = map->getZ();
    const int fx = LZ.first,fy = LZ.second;
    for (int i = 0; i < 4; i++) // search for the four direction
    {
        int sx = fx + dx[i], sy = fy + dy[i];
        //cout<<"sx="<<sx<<";sy="<<sy<<endl;
        if (map->accessable(sx, sy))
        {
            map->change(fx, fy, sx, sy);
            //cout<<"Changing:"<<endl<<*map<<endl;
            if (!(s->count(*map)))// havn't reached
            {
                s->insert(*map);
                q->push({*map, t + 1,++num});
                FatherID[num]=fid;
            }
            map->change(sx, sy, fx, fy);
            //cout << "Back:" << endl << *map << endl;
        }
    }
    return;
}

void Print(Matrix* map,const int id)
{
    static const int _TAB_=4;
    std::ifstream fip;
    std::string fatherline="StatusID="+std::to_string(FatherID[id]);
    fip.open("SearchTree.txt", std::ios_base::in);
    if (!fip.is_open())
        cout << "err!";
    fip.seekg(0,fip.beg);
    //std::ofstream fop;
    //fop.open("test.txt",std::ios_base::out);
    std::string strline;
    int gap=0;
    while (getline(fip, strline))
    {
        //cout<<strline<<endl;
        bool exists = strline.find(fatherline) !=std::string::npos;
        if (exists)
        {
            gap =static_cast<int>(strline.find('S'));
            break;
        }
    }
    std::streampos pos=fip.beg;
    if (gap)
    {
        bool next = false;
        pos = fip.tellg(); // for write and backflash
        while (getline(fip, strline))
        {
            // cout<<strline<<endl;
            bool next = (strline[gap] == 'S');
            if (next)
                break;
            pos = fip.tellg();
        }
    }
    fip.close();

    std::ofstream fop;
    fop.open("SearchTree.txt", std::ios_base::out | std::ios_base::app);
    fop.seekp(pos);
    if (!gap)//the root node
    {
        fop<<"|-"<<"StatusID="<<id<<endl;
        map->Print(fop,_TAB_*2);
    }
    else
    {
        //if (next)    fp.seekg(pos);
        //cout<<static_cast<int>(pos)<<endl;
        cout<<fatherline<<endl;
        fop << "|-" << std::setfill('-') << std::setw(8+gap + _TAB_) << "StatusID=" << id << std::setfill(' ') << endl;
        map->Print(fop, gap + _TAB_+_TAB_ * 2);
    }
    fop.close();
    return;
}