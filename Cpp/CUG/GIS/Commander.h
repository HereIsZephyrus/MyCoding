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
#include<graphics.h>
#include<conio.h>

 enum Areas {
	Toolbar,
	Photo,
	OUT_OF_RANGE
};
 enum Status {
	Hold,
	Draw,
	Drag,
	Clicking,
	NOEXIST_STATUS
};

class Commander {
private:
	MOUSEMSG mouse;
	Status stage;
    unsigned int objID;
protected:
	Areas DictateArea(const MOUSEMSG&);
public:
	Commander() :mouse{}, stage{ Hold },objID{0}{}
	int getCommand();
};

#endif // !_COMMANDER_H_
