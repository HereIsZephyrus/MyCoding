/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-06-11 13:47:16
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-06-11 14:25:28
 * @FilePath: \GIS\Commander.h
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-06-07 20:53:55
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-06-08 22:58:08
 * @FilePath: \GIS\Commander.h
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */

#pragma once
#ifndef _COMMANDER_H_
#define _COMMANDER_H_
#include "Enums.h"
#include<typeinfo>
#include<vector>
#include<graphics.h>
#include<conio.h>
#include<fstream>
using std::vector;
class Response;
class Display;
class Button;
class Polygen;
class Line;

extern std::fstream Basic, Vec;
extern vector<Response *> objList;
extern vector<Display *> elmList;
extern vector<Button *> butList;


class Commander {
friend class Button;
private:
	MOUSEMSG mouse;
	Status stage;
	vector<Response*>::iterator obj;//指向当前响应对象的指针
protected:
	Areas DictateArea(const MOUSEMSG&);
    vector<Response*>::iterator DictateButton(const MOUSEMSG&);
    void UpdateStage(const MOUSEMSG&);
    vector<Response *>::iterator FocusObjID(const MOUSEMSG &);
    void TOclick(vector<Response*>::iterator,const MOUSEMSG &,bool);
public:
	Commander() :mouse{}, stage{ Hold }{
        FlushMouseMsgBuffer();
        obj=objList.end();
    }
	int getCommand();
};

double Distance(const int &, const int &, const int &, const int &);
int CalcLine(const int,const int, Polygen*);
bool CheckEdges(const int, const int, Line*);
bool CheckExceed(const Response*,bool );
bool illegalClick(const MOUSEMSG&);
#endif // !_COMMANDER_H_
