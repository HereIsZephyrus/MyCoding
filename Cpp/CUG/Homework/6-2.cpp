/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-04-22 13:29:55
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-04-22 13:30:09
 * @FilePath: \Homework\6-2.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#include<iostream>

class Point{
    private:
        int m_x{};
        int m_y{};
        int m_z{};

    public:
        Point(int x=0, int y=0, int z=0) : m_x{x}, m_y{y}, m_z{z} {}
        friend std::ostream &operator<<(std::ostream &os, const Point &p)
        {
            return os << "Point(" << p.m_x << ", " << p.m_y << ", " << p.m_z << ')';
        }
};
class Circle:virtual public Point{
private:
    Point m_center;
    int m_radius;
public:
    Circle(const Point &center, int radius) : m_center{},m_radius{radius}
    {
            m_center=std::move(center);
    }
    friend std::ostream& operator<<(std::ostream& out, const Circle& c){
        return out<<"Circle("<<c.m_center<<", radius "<<c.m_radius<<')';
    }
};
class Triangle:virtual public Point{
private:
    Point m_p1;
    Point m_p2;
    Point m_p3;
public:
    Triangle(const Point& p1, const Point& p2, const Point& p3):m_p1{}, m_p2{}, m_p3{}{
        m_p1=std::move(p1);
        m_p2=std::move(p2);
        m_p3=std::move(p3);
    }
    friend std::ostream& operator<<(std::ostream& out, const Triangle& t){
        return out<<"Triangle("<<t.m_p1<<", "<<t.m_p2<<", "<<t.m_p3<<')';
    }
};
class Shape:protected Circle, protected Triangle{
public:
    virtual std::ostream &print(std::ostream &) const = 0;
    friend std::ostream &operator<<(std::ostream &os, const Shape &s){
        return s.print(os);
    }
    virtual ~Shape() = default;
};

int main(){
    Circle c{ Point{ 1, 2, 3 }, 7 };
    std::cout << c << '\n';

    Triangle t{Point{1, 2, 3}, Point{4, 5, 6}, Point{7, 8, 9}};
    std::cout << t << '\n';
    return 0;
}