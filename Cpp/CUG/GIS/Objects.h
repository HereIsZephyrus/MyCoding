#pragma once
#ifndef _OBJECTS_H_
#define _OBJECTS_H_
#include "Solution.h"
#include<vector>
#include<cstring>
#include<string>
using std::vector;
using std::string;
namespace ColorConst {
	constexpr char _dx = 3;
	constexpr char _dy = 3;
	constexpr char BOLD = 3;
	constexpr double ALPHA = 1.0;
}
using namespace ColorConst;
constexpr bool DRAWING = false;
constexpr bool EXISTED = true;

class Response
{
private:
	int X, Y, borderBold, color;
	double alpha;
	static unsigned int count;
	unsigned int id;
public:
	Response(int x, int y, int Bold, int Color, double Alpha) :X(x), Y(y), borderBold(Bold), color(Color), alpha(Alpha) {
		id=++count;
	}
	~Response() {
		--count;
	}
	virtual int ClickLeft(bool) = 0;
	virtual int ClickRight(bool) = 0;
	virtual int ClickMiddle(bool) = 0;
	virtual int Suspend() = 0;
	virtual int Draw() = 0;
    void Move();
	int getX() const;
	int getY() const;
	int getID() const;
	double getColor() const;
	double getAlpha() const;
};
class Display
{
private:
	int X, Y;
	static unsigned int count;
	unsigned int id;
public:
	Display(int x, int y) :X(x), Y(y) {
		id = ++count;
	}
	~Display() {
		--count;
	}
	int getX() const;
	int getY() const;
	int getID() const;
};

class Text {
private:
	int X, Y, color, size;
	string contain;
public:
	Text(): X(1),Y(1),color(BLACK),size(10){}
	Text(int x, int y, int colour, int font,string Contain) :X(x), Y(y), color(colour), size(font),contain(Contain) {}
    int getX() const;
    int getY() const;
    int getColor() const;
};
class Point :public Response
{
private:
	int size;
	Text info;
	enum shape
	{

	};
protected:
	virtual int Create();
	virtual int Delete();
	virtual void DisplayInfo() const;
	virtual int Draw();
public:
	enum type
	{

	};
	Point(int X, int Y, int Bold, int Color, double Alpha, int Size) :Response(X, Y, Bold, Color, Alpha), size(Size) {}
	int getSize() const;
	int getType() const;
	virtual int ClickLeft(bool);
	virtual int ClickRight(bool);
	virtual int Suspend();
	virtual int ClickMiddle(bool);
};
class Borden :public Display
{
private:
	int termX, termY, bold;
protected:
	virtual int Draw();
public:
	Borden(int sX,int sY,int tX,int tY,int Bold=BOLD):Display(sX,sY),termX(tX),termY(tY),bold(Bold){}
	int getTermX() const;
	int getTermY() const;
	int getBold() const;
	virtual void DisplayInfo() const;
};

class Rectangle :public Display
{
private:
	int width, height;
	vector<Text> msg;
	//image
public:
	Rectangle(int x, int y, int w, int h) :Display(x, y), width(w), height(h) {};
	~Rectangle() {
		msg.clear();
	}
};

class Polygen :public Response
{
private:
	vector<Point> points;
	vector<Borden> borders;
	double area;
	bool shownedInfo;
protected:
	double CalcArea();
	int AddPoint();
	int DeletePoint();
	int Bind();
	virtual void DisplayInfo() const;
public:
	Polygen(int X, int Y, int Bold, int Color) :Response(X, Y, Bold, Color, ALPHA), points{}, borders{}, area(0), shownedInfo(false) {}
	~Polygen() {
		points.clear();
		borders.clear();
	}
	virtual int ClickLeft(bool);
	virtual int ClickRight(bool);
	virtual int Suspend();
	virtual int ClickMiddle(bool);
};
class Line :public Response
{
private:
	vector<Point> points;
	vector<Borden> borders;
	double length;
	bool shownedInfo;
protected:
	double CalcLength();
	int AddPoint();
	int DeletePoint();
	int Bind();
	virtual void DisplayInfo() const;
public:
	Line(int X, int Y, int Bold, int Color) :Response(X, Y, Bold, Color, ALPHA), points{}, borders{}, length(0), shownedInfo(false) {}
	~Line() {
		points.clear();
		borders.clear();
	}
	virtual int ClickLeft(bool);
	virtual int ClickRight(bool);
	virtual int Suspend();
	virtual int ClickMiddle(bool);
};
class Button :public Response
{
private:
	int width, height;
	Text info;
public:
	Button(int X, int Y, int Bold, int Color,int w,int h) :Response(X, Y, Bold, Color, ALPHA),width(w),height(h)  {}
	virtual int ClickLeft(bool);
	virtual int ClickRight(bool);
	virtual int Suspend();
	virtual int ClickMiddle(bool);
};
vector<Response*> objList;
vector<Display*> elmList;
#endif // !_OBJECTS_H_

#ifndef _BUTTONS_H_
#define _BUTTONS_H_

enum ButtonType {
	Load,
	Save,
	New,
	Open,
	Exit,
	Switch,
	Draw,
	NOEXIST_BUTTON
};
constexpr int ButtonNum = 11;//一共有11个按钮

class LoadButton :protected Button
{

};
class SaveButton :protected Button
{

};
class NewButton :protected Button
{

};
class OpenButton :protected Button
{

};
class ExitButton :protected Button
{

};
class SwitchButton : protected Button
{

};
class DrawButton :protected Button
{

};

#endif // !_BUTTONS_H_
