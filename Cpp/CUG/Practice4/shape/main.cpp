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
#include<fstream>
#include<cassert>
#include<vector>
#include<cmath>
#include<memory>

using std::ios_base;
using std::cout;
using std::endl;
using std::cin;
int getNum(std::istream& );
int main(){
    std::vector<std::shared_ptr<Shape>> shapes;
    std::ifstream fin("input.txt",ios_base::in);
    //while (!fin.eof()){
    while (true){
        int c=getNum(cin);
        //std::cout<<c<<std::endl;
        //system("pause");
        switch(c){
        case 0:{
            Triangle temp;
            shapes.push_back(std::make_shared<Triangle>(temp.read(cin)));
            break;
            }
        case 1:{
            Rectangle temp;
            shapes.push_back(std::make_shared<Rectangle>(temp.read(cin)));
            break;
            }
        case 2:{
            Square temp;
            shapes.push_back(std::make_shared<Square>(temp.read(cin)));
            break;
            }
        case 3:{
            Circle temp;
            shapes.push_back(std::make_shared<Circle>(temp.read(cin)));
            break;
            }
        case 4:{
            Ellipse temp;
            shapes.push_back(std::make_shared<Ellipse>(temp.read(cin)));
            break;
            }
        default:
            assert(false);
        }
        shapes.back()->write(std::cout) << std::endl;
    }
    for (std::vector<std::shared_ptr<Shape>>::const_iterator it = shapes.begin(); it != shapes.end(); ++it){
        const std::shared_ptr<Shape> shape = *it;
        shape->write(std::cout)<<std::endl;
        //std::cout<<*shape<<std::endl;
    }
    //fin.close();
    std::cin.get();
    std::cin.get();
    return 0;
}
int getNum(std::istream& fin){
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