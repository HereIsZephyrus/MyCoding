/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-06-07 20:53:55
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-06-09 10:18:38
 * @FilePath: \GIS\Commander.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-06-07 20:53:55
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-06-08 13:59:51
 * @FilePath: \GIS\Commander.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#include "Commander.h"

vector<Response *> objList;
vector<Display *> elmList;
vector<Button *> butList;

int Commander::getCommand()
{
	if (MouseHit()) {
		mouse = GetMouseMsg();
		switch (static_cast<int>(DictateArea(mouse)))
		{
		case static_cast<int>(Toolbar) : {//理论上在工具栏中可操作对象是按钮为充分必要的
            ButtonType objButton=DictateButton(mouse);
            if (mouse.uMsg == WM_LBUTTONUP && objButton) // 在有效对象上释放响应
                switch (PressButton(objButton))
                {
                    case 0:
                    {
                        return 0;//Exit
                        break;
                    }
                    case 1:
                    {
                        stage=Drawing;//Load
                        break;
                    }
                }

			break;
		}
		case static_cast<int>(Photo): {
            switch (stage)
            {
            case Drawing: // 在绘制状态下，鼠标左键按下时，响应对象的ClickLeft()函数用以新建对象
            {
                TOclick(obj, mouse, DRAWING);
                break;
            }
            case Hold: // 空载状态，可能将更新已有矢量状态
            {
                vector<Response*>::iterator obj = FocusObjID(mouse);
                if (obj==objList.end())
                    break;
                TOclick(obj, mouse, EXISTED);
                break;
            }
            case Drag:
            {
                vector<Response *>::iterator obj = FocusObjID(mouse);
                if (obj == objList.end())
                    break;
                (* obj)->Move(mouse.x-(*obj)->getX(),mouse.y-(*obj)->getY());
                break;
            }
            case Clicking:
            {
                //感觉没啥好写， 现在也没想到解决鼠标响应冲突的办法
                break;
            }
		    }
            break;
        }
		default://out_of_range
			break;
		}
        UpdateStage(mouse);//更新鼠标对象状态
    }
	else {
		//failed
	}
	return 0;
}

Areas Commander::DictateArea(const MOUSEMSG& mouse)
{
	const int x = mouse.x, y = mouse.y;
	if (x&&y) {
		return Toolbar;
	}
	if (x&&y) {
		return Photo;
	}
	return OUT_OF_RANGE;
}
ButtonType Commander::DictateButton(const MOUSEMSG &mouse)
{
    return NOEXIST_BUTTON;
}

int Commander::PressButton(ButtonType objButton){
    switch (objButton)
    {
    case ButtonType::Exit:
    {

        break;
    }
    case ButtonType::Load:
    {

        break;
    }
    case ButtonType::New:
    {

        break;
    }
    case ButtonType::Open:
    {

        break;
    }
    case ButtonType::Save:
    {

        break;
    }
    case ButtonType::Switch:
    {

        break;
    }
    case ButtonType::Draw:
    {
        return 1;
        break;
    }
    default:
        //failed
        break;
    }
    return 0;
}

void Commander::UpdateStage(const MOUSEMSG &mouse)
{
    switch (mouse.uMsg)
    {
    case WM_LBUTTONDOWN:
    {
        stage = Clicking;
        break;
    }
    case WM_RBUTTONDOWN:
    {
        stage = Clicking;
        break;
    }
    case WM_MBUTTONDOWN:
    {
        if (objID > ButtonNum)
            stage = Drag;
        break;
    }
    case WM_LBUTTONUP:
    {
        stage = Hold;
        break;
    }
    case WM_RBUTTONUP:
    {
        stage = Hold;
        break;
    }
    case WM_MOUSEMOVE: // 鼠标在移动时可能为绘制、移动和空载三种情况，但是没有额外动作
    {
        break;
    }
    default:
        // failed
        break;
    }
    return;
}

void Commander::TOclick(vector<Response*>::iterator obj,const MOUSEMSG& mouse,bool HOLDING)
{
    switch (mouse.uMsg)
    {
    case WM_LBUTTONDOWN:
    {
        (*obj)->ClickLeft(HOLDING);
        break;
    }
    case WM_RBUTTONDOWN:
    {
        (*obj)->ClickRight(HOLDING);
        break;
    }
    case WM_MBUTTONDOWN:
    {
        (*obj)->ClickMiddle(HOLDING);
        break;
    }
    default:
        break;
    }
    return;
}

vector<Response *>::iterator Commander::FocusObjID(const MOUSEMSG &mouse)
{
    const int x = mouse.x, y = mouse.y;
    for (vector<Response *>::iterator it = objList.begin(); it != objList.end(); it++)
    {
        if (typeid(*it) == typeid(Point)) // 指到点的范围内就可以，注意Point的X和Y是中心点
            if (Distance(x, y, (*it)->getX(), (*it)->getY())<(dynamic_cast<Point *>(*it))->getSize())
                return it;
        if (typeid(*it) == typeid(Line))
            if (CheckEdges(x, y, dynamic_cast<Line *>(*it)))
                return it;
        if (typeid(it) == typeid(Polygen))// 通过鼠标x轴坐标经过的绘制边界的奇偶性，判断鼠标是否在对象中
            if ((CalcLine(x, y, dynamic_cast<Polygen *>(*it)) & 1) != 0)
                return it;
        // 理论上Button对象不可能出现在Photo中，后期考虑写一个异常
    }
    return objList.end();
}

double Distance(const int& x1, const int& y1, const int& x2, const int& y2)
{
    return sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
}
int CalcLine(const int x, const int y, Polygen* obj)
{
    return 0;
}
bool CheckEdges(const int x, const int y, Line* obj)
{
    return false;
}