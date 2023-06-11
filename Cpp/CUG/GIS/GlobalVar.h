#pragma once
#ifndef _GLOBAL_H_
#define _GLOBAL_H_
#include<fstream>
#include<iostream>
#include<vector>
#include<cstring>
#include<string>
using std::vector;
using std::string;

namespace streaming {
    using std::fstream;
    using std::ostream;
    using std::istream;
    using std::endl;
    using std::cin;
    using std::cout;
}
using namespace streaming;

class Response;
class Display;
class Button;
class Squareness;

vector<Response*> objList;
vector<Display*> elmList;
vector<Button*> butList;
//fstream Basic, vec;
Squareness toolbar();
Button exitButton();  // 退出按钮
Button drawButton1(); // 画点按钮
Button drawButton2(); // 画线按钮
Button drawButton3(); // 画面按钮
Button openButton();  // 打开vec按钮
Button newButton();   // 新建vec按钮
Button saveButton();  // 保存vec按钮
Button loadButton();  // 加载底图按钮

#endif // !_GLOBAL_H_
