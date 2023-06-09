/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-06-08 13:50:54
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-06-09 10:59:31
 * @FilePath: \GIS\Solution.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#include "Solution.h"
#include "Commander.h"

namespace streaming {
    using std::fstream;
    using std::ostream;
    using std::istream;
    using std::endl;
    using std::cin;
    using std::cout;
}
using namespace streaming;

static fstream Basic, Vec;
void Initialize() {
	initgraph(1280, 720);
    /*
    //绘制Toolbar
    static Rectangle toolbar();
    //...
    elmList.push_back(&toolbar);
    {
        //绘制按钮
        static exitButton ExitButton();
        butList.push_back(&ExitButton);
        //...
    }
    //绘制地图底框
    static Rectangle map();
    elmList.push_back(&map);
    */
    //Basic.open();
    //Vec.open();
	return;
}
void ShutDown() {
    objList.clear();
    elmList.clear();
    butList.clear();
    if (Basic.is_open())    Basic.close();
    if (Vec.is_open())      Vec.close();
	closegraph();
	return;
}