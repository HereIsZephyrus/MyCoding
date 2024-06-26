/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-04-30 10:21:47
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-05-19 23:13:13
 * @FilePath: \shape\main.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */

#include"shape.h"
#include<cassert>
#include<vector>
#include<cmath>
#include<memory>

using std::ios_base;
using std::cout;
using std::endl;
using std::cin;
int getNum(std::ifstream& );
int main(){
    std::vector<std::shared_ptr<Shape>> shapes;
    std::ifstream fin("input.txt",ios_base::in);
    std::cout<<"Please input any number(ex.0):"<<std::endl;
    if (!fin.is_open())
        assert(false);
    while (!fin.eof()){
    //while (true){
        int c=getNum(fin);
        //std::cout<<c<<std::endl;
        //system("pause");
        switch(c){
        case 0:{
            Triangle temp;
            shapes.push_back(std::make_shared<Triangle>(temp.read(fin)));
            break;
            }
        case 1:{
            Rectangle temp;
            shapes.push_back(std::make_shared<Rectangle>(temp.read(fin)));
            break;
            }
        case 2:{
            Square temp;
            shapes.push_back(std::make_shared<Square>(temp.read(fin)));
            break;
            }
        case 3:{
            Circle temp;
            shapes.push_back(std::make_shared<Circle>(temp.read(fin)));
            break;
            }
        case 4:{
            Ellipse temp;
            shapes.push_back(std::make_shared<Ellipse>(temp.read(fin)));
            break;
            }
        default:
            assert(false);
        }
        while (!fin.eof()&!isspace(fin.get()))
            continue; // get rid of spaces
    }
    for (std::vector<std::shared_ptr<Shape>>::const_iterator it = shapes.begin(); it != shapes.end()-1; ++it){
        const std::shared_ptr<Shape> shape = *it;
        //shape->write(std::cout)<<std::endl;
        std::cout<<*shape;
    }
    fin.close();
    std::cin.get();
    std::cin.get();
    return 0;
}
int getNum(std::ifstream& fin){
    char c=fin.get();
    int num=0;
    while (c<'0'||c>'9') c=getchar();
    while (c>='0'&&c<='9'){
        num=num*10+c-'0';
        c=fin.get();
    }
    if (num>10){
        std::cout<<"Error: The data is organized incorrectly"<<std::endl;
        assert(false);
    }
    return num;
}