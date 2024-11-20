/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-04-22 14:01:05
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-04-22 14:02:26
 * @FilePath: \Homework\6-3.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#include <vector>
#include <iostream>
#include<type_traits>
#include<cmath>

class Point{
    private:
        int m_x{};
        int m_y{};
        int m_z{};

    public:
        Point(int x=0, int y=0, int z=0) : m_x{x}, m_y{y}, m_z{z} {}
        friend std::ostream &operator<<(std::ostream &os, const Point &p){
            return os << "Point(" << p.m_x << ", " << p.m_y << ", " << p.m_z << ')';
        }
};
class Circle:public Point{
private:
    Point m_center;
    int m_radius;
public:
    Circle():m_center{},m_radius{}{}
    Circle(const Point &center, int radius) : m_center{},m_radius{radius}{
            m_center=std::move(center);
    }
    friend std::ostream& operator<<(std::ostream& out, const Circle& c){
        return out<<"Circle("<<c.m_center<<", radius "<<c.m_radius<<')';
    }
    int getRadius() const{
        return m_radius;
    }

};
class Triangle:public Point{
private:
    Point m_p1;
    Point m_p2;
    Point m_p3;
public:
    Triangle():m_p1{}, m_p2{}, m_p3{}{}
    Triangle(const Point& p1, const Point& p2, const Point& p3):m_p1{}, m_p2{}, m_p3{}{
        m_p1=std::move(p1);
        m_p2=std::move(p2);
        m_p3=std::move(p3);
    }
    friend std::ostream& operator<<(std::ostream& out, const Triangle& t){
        return out<<"Triangle("<<t.m_p1<<", "<<t.m_p2<<", "<<t.m_p3<<')';
    }
};
class Shape:virtual public Circle,virtual public Triangle{//到现在了我还是不知道这个虚类什么用，套个虚接口但是没意义啊
public:
    Shape():Circle(),Triangle(){}
    Shape(int x,int y,int z,int r):Circle(Point{x,y,z},r){}
    Shape(const Point& p1, const Point& p2, const Point& p3):Triangle(p1,p2,p3){}
    //virtual std::ostream &print(std::ostream &) const = 0;
    //friend std::ostream &operator<<(std::ostream &os, const Shape &s){
    //    return s.print(os);
    //}
    ~Shape() = default;
};
int getLargestRadius(const std::vector<Shape *> &shapes){
    int Max = -1;
    for (auto &i : shapes)
        if (auto circle = dynamic_cast<Circle *>(i))
            Max = std::max(Max, circle->getRadius());
    return Max;
}
int main(){
    std::vector<Shape *> v;
    v.push_back(new Shape(1,2,3,7));
    v.push_back(new Shape(Point{1, 2, 3}, Point{4, 5, 6}, Point{7, 8, 9}));
    v.push_back(new Shape(4,5,6,3));
    // print each shape in vector v on its own line here
    std::cout << "The largest radius is: " << getLargestRadius(v) << '\n'; // write this function
    // delete each element in the vector here
    for (auto &i : v)    delete i;
    return 0;
}