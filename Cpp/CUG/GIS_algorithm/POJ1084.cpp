/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2024-05-30 15:40:00
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2024-05-30 16:46:27
 * @FilePath: \GISalgorithm\POJ1084.cpp
 * @Description:
 * @
 * @Copyright (c) 2024 by ChanningTong, All Rights Reserved.
 */
#include <iostream>
#include <vector>
#include <cmath>

class Matrix{
private:
    std::vector<int> mat;
    int n,size;
    bool check(const int x1,const int y1,const int x2,const int y2);
public:
    Matrix(int n):n(n),size(2 * n * (n-1)){mat.resize(size);}
    void remove(int id) {mat[id-1] = -1;}
    void calc();
    int max(int &id);
    void update(int id){
        remove(id);
        calc();
    }
    ~Matrix()   {mat.clear();}
};

void solve(){
    int n, k;
    Matrix *mat = new Matrix(n);
    std::cin >> n >> k;
    while (k--){
        int id;
        std::cin >> id;
        mat -> remove(id);
    }
    mat -> calc();
    int id = 0,count = 0;
    while(mat->max(id)){
        mat->update(id);
        count++;
    }
    std::cout<<count;
    return;
}

int main(){
    int t;
    std::cin >> t;
    while (t--)    solve();
    return 0;
}

int Matrix::max(int &id){
    int res = 0;
    for (int i = 0; i < size; i++)
        if (mat[i] > res){
            res = mat[i];
            id = i + 1;
        }
    return res;
}
void Matrix::calc(){
    for (int x = 0; x < n; x++)
        for (int y = 0; y < n; y++){
            check(x,y,x+1,y+1);
            for (int a = 2; a <= n; a++){
                if (x + a <= n && y + a <= n)       check(x,y,x+a,y+a);
                if (x + a <= n && y + 1 - a >=0)    check(x,y+1-a,x+a,y+1);
                if (x + 1 - a >= 0 && y + a <= n)   check(x+1-a,y,x+1,y+a);
                if (x + 1 - a >= 0 && y + 1 - a >=0)check(x+1-a,y+1-a,x+1,y+1);
            }
        }
    return;
}

bool Matrix::check(const int x1,const int y1,const int x2,const int y2){
    return false;
}