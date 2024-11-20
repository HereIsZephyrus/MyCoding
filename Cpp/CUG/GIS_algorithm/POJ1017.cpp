/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2024-05-30 15:40:00
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2024-05-30 16:06:00
 * @FilePath: \undefinedc:\Users\Administrator\GitHub\MyCoding\Cpp\CUG\GISalgorithm\POJ1017.cpp
 * @Description:
 * @
 * @Copyright (c) 2024 by ChanningTong, All Rights Reserved.
 */
#include<iostream>
#include<algorithm>
#include<array>
#include<queue>
#include<cmath>
const int containerSize = 6;
const int typeNum = 6;

class Container{
    int x,y,z;
    public:
    Container() : x(0), y(0), z(0){}
    Container(int x, int y, int z) : x(x), y(y), z(z){}
    int getX() const { return x; }
    int getY() const { return y; }
    int getZ() const { return z; }
    int getShortest() const { return std::min(x,y,z); }
    int getLongest() const { return std::max(x,y,z); }
    bool operator < (const Container &c) const {
        return std::min(x,y,z) < std::min(c.x,c.y,c.z);
    }
};
bool empty(const std::array<int,typeNum> &num){
    for (int i = 0; i < typeNum; i++)
        if (num[i]) return false;
    return true;
}
void update(std::priority_queue<Container> &q, int x, int y, int z, int numX, int numY, int numZ){

}
int solve(std::array<int,typeNum> &num){
    int ans = 0;
    while (!empty(num)){
        ans++;
        std::priority_queue<Container> q;
        q.push(Container(containerSize,containerSize,containerSize));
        while (!q.empty() && !empty(num)){
            Container forLoad = q.top();
            q.pop();
            for (std::array<int,typeNum>::iterator it = num.begin(); it != num.end(); it++){
                int size = std::distance(it,num.begin()) + 1;
                if (forLoad.getShortest() < size) continue;
                if (*it){
                    int numX = forLoad.getX()/size, numY = forLoad.getY()/size, numZ = forLoad.getZ()/size;
                    int take = numX * numY * numZ;
                    if (take < *it){
                        *it -= take;
                        update(q,forLoad.getX(),forLoad.getY(),forLoad.getZ(),numX,numY,numZ);
                    }
                    else{
                        *it = 0;
                        //aaaaa hard
                    }
                }
            }
        }
    }
    return ans;
}
int main(){
    std::array<int,typeNum> num;
    for (int i = 0; i < typeNum; i++)
        std::cin>>num[i];
    std::reverse(num.begin(),num.end());
    while (!empty(num)){
        std::cout<<solve(num)<<std::endl;
        for (int i = 0; i < typeNum; i++)
            std::cin>>num[i];
        std::reverse(num.begin(),num.end());
    }

    return 0;
}