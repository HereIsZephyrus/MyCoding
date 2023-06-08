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
/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-06-07 20:53:55
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-06-07 21:35:42
 * @FilePath: \GIS\Commander.h
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#pragma once
#ifndef _COMMANDER_H_
#define _COMMANDER_H_
#include "Solution.h"
#include "Objects.h"
#include<typeinfo>

 enum Areas {
	Toolbar,
	Photo,
	OUT_OF_RANGE
};
 enum Status {
	 Hold,
	 Drawing,
	 Drag,
	 Clicking,
	NOEXIST_STATUS
};

class Commander {
private:
	MOUSEMSG mouse;
	Status stage;
    unsigned int objID;
	vector<Response*>::iterator obj;//指向当前响应对象的指针
protected:
	Areas DictateArea(const MOUSEMSG&);
    ButtonType DictateButton(const MOUSEMSG&);
    void UpdateStage(const MOUSEMSG&);
    void PressButton(ButtonType);
    vector<Response *>::iterator FocusObjID(const MOUSEMSG &);
    void TOclick(vector<Response*>::iterator,const MOUSEMSG &,bool);
public:
	Commander() :mouse{}, stage{ Hold },objID{0}{
        FlushMouseMsgBuffer();
        obj=nullptr;
    }
	int getCommand();
};

double Distance(const int, const int, const int, const int);
int CalcLine(const int,const int, vector<Polygen*>::iterator&);
bool CheckEdges(const int, const int, vector<Line*>::iterator&);
#endif // !_COMMANDER_H_
