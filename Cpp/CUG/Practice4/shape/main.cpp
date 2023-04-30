/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-04-30 10:21:47
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-04-30 10:24:54
 * @FilePath: \Practice4\shape\main.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#include<iostream>
#include<fstream>
#include<cassert>
#include<vector>
#include<cmath>
#include<memory>
#include"shape.h"

enum ShapeType{
    Triangle,
    Rectangle,
    Square,
    Circle,
    Ellipse,
    MAX_SHAPE_TYPE
};
int getNum(std::ifstream& );
int main(){
    std::vector<std::unique_ptr<Shape>> shapes;
    std::ifstream fin("input.txt");
    while (~fin.eof()){
        ShapeType c=static_cast<ShapeType>(getNum(fin));
        switch(c){
            case Triangle:
                std::unique_ptr<Triangle> pTriangle(new Triangle(Triangle::read(fin)));
                shapes.push_back(pTriangle);
                break;
            case Rectangle:
                shapes.push_back(std::make_unique<Rectangle>(Rectangle::read(fin)));
                break;
            case Square:
                shapes.push_back(std::make_unique<Square>(Square::read(fin)));
                break;
            case Circle:
                shapes.push_back(std::make_unique<Circle>(Circle::read(fin)));
                break;
            case Ellipse:
                shapes.push_back(std::make_unique<Ellipse>(Ellipse::read(fin)));
                break;
            default:
                assert(false);
        }
    }
    for (auto& shape:shapes){
        std::cout<<*shape;
    }
    return 0;
}
int getNum(std::ifstream& fin){
    char c=getchar();
    int num=0;
    while (c<'0'||c>'9') c=getchar();
    while (c>='0'&&c<='9'){
        num=num*10+c-'0';
        c=getchar();
    }
    if (num>10){
        std::cout<<"Error: The data is organized incorrectly"<<std::endl;
        assert(false);
    }
    return num;
}