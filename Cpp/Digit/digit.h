/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-12-30 16:44:22
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-12-30 19:55:14
 * @FilePath: \AIfoundation\digit.h
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#pragma once
#include <iostream>
#include <algorithm>
#include <cstdio>
#include <cstring>
#include <string>
#include <queue>
#include <vector>
#include <iomanip>
#include <set>
using std::cin;
using std::cout;
using std::endl;
using std::make_pair;

constexpr int MAXN = 1000;

class Matrix
{
private:
    size_t n;
    std::vector<std::vector<int>> num;
    std::vector<std::vector<int>> term;
    bool reachable = false;
    int h = 0;
protected:
    int countInverse(const std::vector<int> &);
public:
    Matrix() : n(0),h(0) {}
    void CalcH();
    Matrix(size_t size, const std::vector<int> &puzzle, const std::vector<int> &goal)
    {
        build(size, puzzle, goal);
    }
    // Matrix(Matrix&& outside){n=outside.n; num=outside.num; term=outside.term; h=outside.h;}
    Matrix(const Matrix &outside){n = outside.n;num = outside.num;term = outside.term;h=outside.h;}
    ~Matrix() {}
    bool getReachable() const { return reachable; }
    bool accessable(int x, int y) const { return (x >= 0) && (y >= 0) && (x < n) && (y < n); }
    std::string checkValid(const std::vector<int> &, const std::vector<int> &);
    void setDigit(const int x, const int y, int val){num[x][y] = val;return;}
    void change(int fx, int fy, int sx, int sy) { std::swap(num[fx][fy], num[sx][sy]); CalcH();}
    void Init();
    void build(size_t size, const std::vector<int> &puzzle, const std::vector<int> &goal);
    std::pair<int,int> getZ();
    int getH() const {return h;}
    Matrix &operator=(const Matrix &other)
    {
        if (this != &other)
        {
            n = other.n;
            num = other.num;
            term = other.term;
        }
    }
    Matrix &operator=(Matrix &&outside) // move the outer mapping into the solver
    {
        if (this != &outside)
        {
            n = outside.n;
            num = outside.num;
            term = outside.term;
        }
        return *this;
    }
    friend std::istream &operator>>(std::istream &is, Matrix &x)
    {
        cout << "Please input the size of the puzzle:" << endl;
        cin >> x.n;
        x.Init();
        while (x.getReachable() == false)
        {
            cout << "Please set again." << endl;
            x.Init();
        }
    }
    friend std::ostream &operator<<(std::ostream &os, const Matrix &m)
    {
        for (std::vector<std::vector<int>>::const_iterator itx = m.num.begin(); itx != m.num.end(); ++itx)
        {
            std::vector<int> x = *itx;
            for (std::vector<int>::iterator ity = x.begin(); ity != x.end(); ++ity)
                os << *ity;
            os << endl;
        }
        return os;
    }

    std::ostream & Print(std::ostream &os,const int gap)
    {
        for (std::vector<std::vector<int>>::iterator itx = this->num.begin(); itx != this->num.end(); ++itx)
        {
            std::vector<int> x = *itx;
            os << '|'<<std::setw(gap);
            for (std::vector<int>::iterator ity = x.begin(); ity != x.end(); ++ity)
                os << *ity;
            os << endl;
        }
        return os;
    }
    bool operator<(const Matrix &x) const{return num<x.num;}
};

struct Node
{
    Matrix map;
    int deep;
    int id;
    friend bool operator<(const Node &x,const Node &y)
    {
        return x.deep + x.map.getH() > y.deep + y.map.getH();
    }
};

struct cmp
{
    bool operator()(Node &x, Node &y)
    {
        const int tx = x.deep, ty = y.deep;
        Matrix *mapx = &x.map;
        Matrix *mapy = &y.map;
        return tx + mapx->getH() > ty + mapy->getH();
    }
};

void Search(std::priority_queue<Node> *, std::set<Matrix> *, Matrix *, const int, const int);
void Print(Matrix*,const int);