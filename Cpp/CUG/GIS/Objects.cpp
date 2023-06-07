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
double Response::getAlpha() const    {return alpha;}

int Display::getX() const               {return X;}
int Display::getY() const               {return Y;}
int Display::getID() const              {return id;}

int Text::getX() const                  {return X;}
int Text::getY() const                  {return Y;}
double Text::getColor() const         {return color;}

int Point::getSize() const              {return size;}
int Point::getType() const              {return type;}

int Borden::getTermX() const             {return termX;}
int Borden::getTermY() const             {return termY;}
int Borden::getBold() const             {return bold;}

int Point::ClickLeft()
{
}
int Point::ClickRight()
{
}
int Point::Suspend()
{
}
int Point::ClickMiddle()
{
}
int Point::Draw()
{
}
int Point::Create()
{
}
int Point::Delete()
{
}
void Point::DisplayInfo() const
{
}

int Borden::Draw()
{
}

int Polygen::ClickLeft()
{
}
int Polygen::ClickRight()
{
}
int Polygen::Suspend()
{
}
int Polygen::ClickMiddle()
{
}

int Line::ClickLeft()
{
}
int Line::ClickRight()
{
}
int Line::Suspend()
{
}
int Line::ClickMiddle()
{
}