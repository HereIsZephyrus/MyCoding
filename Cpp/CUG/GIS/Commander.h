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
    Response * obj;//指向当前响应对象的指针
protected:
	Areas DictateArea(const MOUSEMSG&);
    ButtonType DictateButton(const MOUSEMSG&);
    void UpdateStage(const MOUSEMSG&);
    void PressButton(ButtonType);
    unsigned int FocusObjID(const MOUSEMSG &);
    Response * getObj(const unsigned int&);
    void TOclick(Response *,const MOUSEMSG &,bool);
public:
	Commander() :mouse{}, stage{ Hold },objID{0}{
        FlushMouseMsgBuffer();
        obj=nullptr;
    }
	int getCommand();
};

#endif // !_COMMANDER_H_
