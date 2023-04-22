/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-04-22 13:17:43
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-04-22 13:20:22
 * @FilePath: \Homework\6-1.cpp
 * @Description:
 * 创建一个名为 Shape 的抽象类。
 * 这个类应该有三个函数：一个接受并返回 std::ostream& 的纯虚函数print、一个重载 operator<< 和一个空的虚析构函数。
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#include<iostream>
#include<fstream>
#include<cstring>
#include<string>

class Shape{
    std::string content;
    public:
        virtual std::ostream& print(std::ostream&) const;
        friend std::ostream& operator<<(std::ostream& os, const Shape& s){
            return s.print(os);
        }
        virtual ~Shape() = default;
};
int main(){
    return 0;
}
std::ostream& Shape::print(std::ostream &os) const{
    os<<Shape::content<<std::endl;
    return os;
}