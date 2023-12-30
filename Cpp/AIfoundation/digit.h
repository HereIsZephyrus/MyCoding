#pragma once
#include <iostream>
#include <algorithm>
#include <cstdio>
#include <cstring>
#include <queue>
#include <vector>
#include <set>
using std::cin;
using std::cout;
using std::endl;
using std::make_pair;

const int dx[4] = {1, -1, 0, 0}, dy[4] = {0, 0, 1, -1};
constexpr int MAXN = 10;
int fx, fy;
char ch;

class Matrix
{
private:
    size_t n;
    int h = -1;
    std::vector<std::vector<int>> num;
    std::vector<std::vector<int>> term;
    bool reachable = false;

protected:
    int countInverse(const std::vector<int> &);
    int CalcH();

public:
    Matrix() : n(0), h(-1) {}
    Matrix(size_t size, const std::vector<int> &puzzle, const std::vector<int> &goal)
    {
        build(size, puzzle, goal);
        h = CalcH();
    }
    // Matrix(Matrix&& outside){n=outside.n; num=outside.num; term=outside.term; h=outside.h;}
    ~Matrix() {}
    bool getReachable() const { return reachable; }
    bool accessable(int x, int y) const { return (x >= 0) && (y >= 0) && (x < n) && (y < n); }
    std::string checkValid(const std::vector<int> &, const std::vector<int> &);
    void setDigit(const int x, const int y, int val){num[x][y] = val;return;}
    void change(int fx, int fy, int sx, int sy) { std::swap(num[fx][fy], num[sx][sy]); }
    void Init();
    void build(size_t size, const std::vector<int> &puzzle, const std::vector<int> &goal);
    std::pair<int,int> getZ();
    int getH()
    {
        if (h < 0)
            h = CalcH(); // alright, cannot call a non-const method with a const object
        return h;
    }
    Matrix &operator=(const Matrix &other)
    {
        if (this != &other)
        {
            n = other.n;
            h = other.h;
            num = other.num;
            term = other.term;
        }
    }
    Matrix &operator=(Matrix &&outside) // move the outer mapping into the solver
    {
        if (this != &outside)
        {
            n = outside.n;
            h = outside.h;
            num = outside.num;
            term = outside.term;
        }
        return *this;
    }
    friend bool operator<(const Matrix &f1, const Matrix &f2)
    {
        size_t size = f1.n;
        for (int i = 0; i < size; ++i)
            for (int j = 0; j < size; ++j)
                if (f1.num[i][j] != f2.num[i][j])
                    return f1.num[i][j] < f2.num[i][j];
        return false;
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
    friend std::ostream &operator<<(std::ostream &os, const Matrix &x)
    {
        for (std::vector<std::vector<int>>::const_iterator itx = x.num.begin(); itx != x.num.end(); ++itx)
        {
            std::vector<int> x = *itx;
            for (std::vector<int>::iterator ity = x.begin(); ity != x.end(); ++ity)
                os << *ity;
            os << endl;
        }
        return os;
    }
};

typedef std::pair<Matrix, int> countedMap;
struct cmp
{
    bool operator()(countedMap &x, countedMap &y)
    {
        const int tx = x.second, ty = y.second;
        Matrix *mapx = &x.first;
        Matrix *mapy = &y.first;
        return tx + mapx->getH() > ty + mapy->getH();
    }
};