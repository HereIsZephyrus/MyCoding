/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-06-11 13:47:16
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-06-11 14:44:55
 * @FilePath: \GIS\Objects.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-06-07 20:53:55
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-06-07 21:25:06
 * @FilePath: \GIS\Objects.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#include "Objects.h"
#include "GlobalVar.h"

//extern vector<Response*> objList;
//extern vector<Display*> elmList;
//extern vector<Button*> butList;
//extern fstream Basic, Vec;

int Response::getX() const              {return X;}
int Response::getY() const              {return Y;}
int Response::getID() const             {return id;}
double Response::getColor() const     {return color;}
double Response::getAlpha() const { return alpha; }
void Response::Move(const int& dx, const int& dy)
{
    //对对象进行移动，并用EdgeError类处理非法移动
    return;
}

int Display::getX() const               {return X;}
int Display::getY() const               {return Y;}
int Display::getID() const              {return id;}

int Text::getX() const                  {return X;}
int Text::getY() const                  {return Y;}
int Text::getColor() const         {return color;}

int Point::getSize() const              {return size;}

int Borden::getTermX() const             {return termX;}
int Borden::getTermY() const             {return termY;}
int Borden::getBold() const             {return bold;}

int Point::ClickLeft(bool Status, const MOUSEMSG& mouse)
{
    if (Status == EXISTED)
    {
        DisplayInfo();
        return 0;
    }
    _Draw(mouse.x,mouse.y);
	return 0;
}
int Point::ClickRight(bool Status, const MOUSEMSG &mouse)
{
    if (Status == EXISTED) //显示文本框确认
    {
        /*
        HWND hnd = GetHWnd();
        SetWindowText(hnd, "警告！");
        int isDelete = MessageBox("您确定要删除该点吗");
        if (isDelete == IDCANCEL)
            return 0;
        */
    }
    _Delete();
    return 0;
}
int Point::Suspend()
{
    color = 1; alpha = 0.8;
    return 0;
}
int Point::_Draw(const int & x,const int &y)
{
    X = x;  Y = y;
    color = 1;  size = _SIZE_;
    fillcircle(X,Y,size);
    return 0;
}
int Point::_Delete()
{

    return 0;
}
void Point::DisplayInfo() const
{
    //MessageBox();
    return;
}

int Borden::_Draw()
{
    return 0;
}

int Polygen::ClickLeft(bool Status, const MOUSEMSG &mouse)
{
    return 0;
}
int Polygen::ClickRight(bool Status, const MOUSEMSG &mouse)
{
    return 0;
}
int Polygen::Suspend()
{
    return 0;
}
double Polygen::CalcArea()
{
    return 0;
}
int Polygen::_AddPoint()
{
    return 0;
}
int Polygen::_DeletePoint()
{
    return 0;
}
int Polygen::_Bind()
{
    return 0;
}
int Polygen::_Draw()
{
    unsigned int num = 0;
    //POINT pts[] = {};
    //fillpolygon(pts, num);
    return 0;
}
void Polygen::DisplayInfo() const
{
    return;
}

int Line::ClickLeft(bool Status, const MOUSEMSG &mouse)
{
    return 0;
}
int Line::ClickRight(bool Status, const MOUSEMSG &mouse)
{
    return 0;
}
int Line::Suspend()
{
    return 0;
}

int Button::ClickLeft(bool Status, const MOUSEMSG &mouse)
{
    return 0;
}
int Button::ClickRight(bool Status, const MOUSEMSG &mouse)
{
    return 0;
}
int Button::Suspend()
{
    return 0;
}
int Button::Press(Status stage, const MOUSEMSG& mouse, vector<Response*>::iterator& obj) {
    if (type == Exit)
        return 0;
    switch (type)
    {
    case Load:
    {
        wchar_t filename[50];
        InputBox(filename, 50, L"请输入图片绝对路径与完整名称");
        //Vec.open(filename, std::ios_base::in);
        //...
        //Vec.close();
        break;
    }
    case New:
    {
        wchar_t filename[50];
        InputBox(filename, 50, L"请输入文件名称（默认保存在程序所在文件夹内");
        //Vec.open(filename, std::ios_base::out);
        //保持打开状态，直到用户手动保存或者在关闭程序时被动保存
        break;
    }
    case Open:
    {
        wchar_t filename[50];
        InputBox(filename, 50, L"请输入文件绝对路径与完整名称");
        //Vec.open(filename, std::ios_base::in);
        //...
        //保持打开状态，直到用户手动保存或者在关闭程序时被动保存
        break;
    }
    case Save:
    {
        //Vec.close();
        break;
    }
    case Switch:
    {
        if (stage == Drag)    stage = Hold;
        if (stage == Hold)    stage = Drag;
        break;
    }
    case DrawPoint:
    {
        stage = Drawing;
        const int x = mouse.x;
        //objList.push_back(new Point());
        obj = objList.end() - 1;
        break;
    }
    case DrawLine:
    {
        stage = Drawing;
        const int x = mouse.x;
        //objList.push_back(new Line());
        obj = objList.end() - 1;
        break;
    }
    case DrawPolygen:
    {
        stage = Drawing;
        const int x = mouse.x;
        //objList.push_back(new Polygen());
        obj = objList.end() - 1;
        break;
    }
    default: {
        break;
    }
    }
        return 0;
}
int Button::_Draw()
{
    //fillroundrect();
    return 0;
}