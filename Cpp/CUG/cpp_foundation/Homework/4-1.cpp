/*** 
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-25 19:49:26
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-03-25 20:12:04
 * @FilePath: \undefinedc:\Users\Administrator\GitHub\MyCoding\Cpp\CUG\Homework\4-1.cpp
 * @Description: 
 * @
 * @Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
#include<iostream>
using namespace std;

const float ConcretePrice = 20.0;
const float FencePrice = 35.0;      
const float widening = 3.0;         
const float pi = 3.1415926;         
class PoolRim{
    float width, height;
    float r=height/2+widening;
    public:
        PoolRim(float w, float h):width(w), height(h){}
        float Circumference()  {return 2 * width + 2 * pi * r;}
        float Area()   {return width*(height+2*widening) + pi*r*r;}
};
class Rectangle{
    float width, height;
    public:
        Rectangle(float w, float h):width(w), height(h){}
        float Area() {return width*height;}
};
int main (){
    float FenceCost, ConcreteCost; 
    float width, height;
    cout << "Enter the width and height of the pool: ";
    cin >> width >> height;
    
    PoolRim   poolRim(width, height);
    Rectangle Pool(width, height);

    FenceCost = poolRim.Circumference() * FencePrice;
    cout << "Fencing Cost is " << FenceCost << endl;
    
    ConcreteCost = (poolRim.Area() - Pool.Area())*ConcretePrice;
    cout << "Concrete Cost is " << ConcreteCost << endl;
    cin.get();
    cin.get();
    return 0;
}