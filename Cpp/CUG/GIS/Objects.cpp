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

int Response::getX() const              {return X;}
int Response::getY() const              {return Y;}
int Response::getID() const             {return id;}
double Response::getColor() const     {return color;}
double Response::getAlpha() const { return alpha; }
void Response::Move()
{
    return;
}

int Display::getX() const               {return X;}
int Display::getY() const               {return Y;}
int Display::getID() const              {return id;}

int Text::getX() const                  {return X;}
int Text::getY() const                  {return Y;}
int Text::getColor() const         {return color;}

int Point::getSize() const              {return size;}
//int Point::getType() const              {return type;}

int Borden::getTermX() const             {return termX;}
int Borden::getTermY() const             {return termY;}
int Borden::getBold() const             {return bold;}

int Point::ClickLeft(bool Status)
{
	return 0;
}
int Point::ClickRight(bool Status)
{
    return 0;
}
int Point::Suspend()
{
    return 0;
}
int Point::ClickMiddle(bool Status)
{
    return 0;
}
int Point::Draw()
{
    return 0;
}
int Point::Create()
{
    return 0;
}
int Point::Delete()
{
    return 0;
}
void Point::DisplayInfo() const
{
    return;
}

int Borden::Draw()
{
    return 0;
}

int Polygen::ClickLeft(bool Status)
{
    return 0;
}
int Polygen::ClickRight(bool Status)
{
    return 0;
}
int Polygen::Suspend()
{
    return 0;
}
int Polygen::ClickMiddle(bool Status)
{
    return 0;
}

int Line::ClickLeft(bool Status)
{
    return 0;
}
int Line::ClickRight(bool Status)
{
    return 0;
}
int Line::Suspend()
{
    return 0;
}
int Line::ClickMiddle(bool Status)
{
    return 0;
}