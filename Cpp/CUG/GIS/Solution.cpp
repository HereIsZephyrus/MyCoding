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

void Initialize(const Commander& cmder) {
	initgraph(1280, 720);
    //绘制Toolbar
    //...
    /*
    //extern Squareness toolbar();
    elmList.push_back(&toolbar);
    {
        //绘制按钮
        //extern Button exitButton();//退出按钮
        butList.push_back(&exitButton);
        exitButton._Draw();
        //extern Button drawButton1 ();//画点按钮
        butList.push_back(&drawButton1);
        drawButton1._Draw();
        //extern Button drawButton2();//画线按钮
        butList.push_back(&drawButton2);
        drawButton2._Draw();
        //extern Button drawButton3();//画面按钮
        butList.push_back(&drawButton3);
        drawButton3._Draw();
        //extern Button openButton();//打开vec按钮
        butList.push_back(&openButton);
        openButton._Draw();
        //extern Button newButton();//新建vec按钮
        butList.push_back(&newButton);
        newButton._Draw();
        //extern Button saveButton ();//保存vec按钮
        butList.push_back(&saveButton);
        saveButton._Draw();
        //extern Button loadButton();//加载底图按钮
        butList.push_back(&loadButton);
        loadButton._Draw();
    }
    //绘制地图底框
    static Squareness map();
    elmList.push_back(&map);

    loadButton.Press(cmder.stage,cmder.mouse,cmder.obj);//加载一张先
    */
	return;
}
void ShutDown(const Commander& cmder) {
    objList.clear();
    elmList.clear();
    butList.clear();
    /*
    if (Basic.is_open()) {
        //这是逻辑错误，不需要管理，但需要被检测
        Basic.close();
    }
    if (Vec.is_open()) {
        Vec.close();
        //saveButton.Press(cmder.stage,cmder.mouse,cmder.obj);
        //说明是意外退出的，需要帮用户保存
    }
    */
	closegraph();
	return;
}