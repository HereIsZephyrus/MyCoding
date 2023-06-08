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

int Commander::getCommand()
{
	if (MouseHit()) {
		mouse = GetMouseMsg();
		switch (static_cast<int>(DictateArea(mouse)))
		{
		case static_cast<int>(Toolbar) : {//理论上在工具栏中可操作对象是按钮为充分必要的
            ButtonType objButton=DictateButton(mouse);
            if (mouse.uMsg == WM_LBUTTONUP && objButton) // 在有效对象上释放响应
                PressButton(objButton);
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
                const unsigned int objID = FocusObjID(mouse);
                if (!objID)
                    break;
                obj = getObj(objID);
                TOclick(obj, mouse, EXISTED);
                break;
            }
            case Drag:
            {
                const unsigned int objID = FocusObjID(mouse);
                if (!objID)
                    break;
                obj = getObj(objID);
                obj->Move();
                break;
            }
            }
		}
		default://out_of_range
			break;
		}
        UpdateStage(mouse);
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
ButtonType DictateButton(const MOUSEMSG& mouse)
{
    return NOEXIST_BUTTON;
}

void Commander::PressButton(ButtonType objButton){
    switch (objButton)
    {
    case static_cast<int>(ButtonType::Exit):
    {

        break;
    }
    case static_cast<int>(ButtonType::Load):
    {

        break;
    }
    case static_cast<int>(ButtonType::New):
    {

        break;
    }
    case static_cast<int>(ButtonType::Open):
    {

        break;
    }
    case static_cast<int>(ButtonType::Save):
    {

        break;
    }
    case static_cast<int>(ButtonType::Switch):
    {

        break;
    }
    case static_cast<int>(ButtonType::Draw):
    {

        break;
    }
    default:
        //failed
        break;
    }
    return;
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

void Commander::TOclick(Response* obj,const MOUSEMSG& mouse,bool HOLDING)
{
    switch (mouse.uMsg)
    {
    case WM_LBUTTONDOWN:
    {
        obj->ClickLeft(HOLDING);
        break;
    }
    case WM_RBUTTONDOWN:
    {
        obj->ClickRight(HOLDING);
        break;
    }
    case WM_MBUTTONDOWN:
    {
        obj->ClickMiddle(HOLDING);
        break;
    }
    default:
        break;
    }
    return;
}