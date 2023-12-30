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
using std::cin;
using std::cout;
using std::endl;
using std::make_pair;

std::priority_queue<countedMap, std::vector<countedMap>,cmp> q; //search queue
std::set<Matrix> s; //path storage

void Init(int n);

int main()
{
    Matrix mapping;
    cin>>mapping;
    q.push(make_pair(mapping,0));
    while (!q.empty())
    {
        auto x = q.top();
        const int t=x.second;
        Matrix* map=&x.first;
        q.pop();
        if (map->getH() == 0) // Solve it!
        {
            cout << "The step counts " << t<< endl<<*map;
            return 0;
        }
        std::pair<int,int> LZ=map->getZ();
        fx=LZ.first;  fy=LZ.second;
        for (int i = 0; i < 4; i++) // search for the four direction
        {
            int sx = fx + dx[i], sy = fy + dy[i];
            if (map->accessable(sx,sy))
            {
                map->change(fx,fy,sx,sy);
                if (s.count(*map))
                {
                    s.insert(*map);
                    q.push(make_pair(*map,t+1));
                }
                map->change(sx,sy,fx,fy);
            }
        }
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

void Matrix::setDigit(const int x,const int y,int val)
{
    num[x][y]=val;
    return;
}

int Matrix::CalcH()
{
    int res=0;
    for (int i=0; i<n; ++i)
        for (int j=0; j<n; ++j)
            if (num[i][j]!= term[i][j])
                res++;
    return res;
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
}

std::pair<int,int> Matrix::getZ()
{
    std::pair<int,int> res;
    for (std::vector<std::vector<int>>::iterator itx = num.begin(); itx != num.end(); ++itx)
    {
        std::vector<int> x = *itx;
        for (std::vector<int>::iterator ity = x.begin(); ity != x.end(); ++ity)
            if ((*ity)=0)
                res = make_pair(static_cast<int>(itx-num.begin()),static_cast<int>(ity-x.begin()));
    }
    return res;
}