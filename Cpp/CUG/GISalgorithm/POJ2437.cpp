/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2024-05-30 15:40:00
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2024-05-30 20:50:27
 * @FilePath: \GISalgorithm\POJ2437.cpp
 * @Description:
 * @
 * @Copyright (c) 2024 by ChanningTong, All Rights Reserved.
 */
#include<iostream>
#include<vector>
#include<algorithm>
#include<cmath>

class Pool{
    int begin,end;
public:
    Pool(int b,int e):begin(b),end(e){}
    int getBegin(){return begin;}
    int getEnd(){return end;}
    bool operator<(const Pool& pool){
        if (begin == pool.begin)  return end < pool.end;
        return begin < pool.begin;
    }
};

int main(){
    int n,len;
    std::cin>>n>>len;
    std::vector<Pool> pools;
    for (int i = 0; i < n; i++){
        int b,e;
        std::cin>>b>>e;
        pools.push_back(Pool(b,e));
    }
    std::sort(pools.begin(),pools.end());
    int covered = 0,count = 0;
    for (std::vector<Pool>::iterator it = pools.begin(); it != pools.end(); it++){
        if (it->getEnd() <= covered) continue;
        int head = std::max(it->getBegin(),covered);
        int increase = (it->getEnd() - head -1)/len + 1;
        covered = head + increase * len;
        count += increase;
    }
    std::cout<<count<<std::endl;
    return 0;
}