#pragma once
#ifndef _OBJECTS_H_
#define _OBJECTS_H_
#include "Enums.h"
#include<graphics.h>
#include<conio.h>
#include<cstring>
#include<string>
#include<vector>
using std::string;
using std::vector;
namespace ColorConst {
	constexpr char _dx = 3;
	constexpr char _dy = 3;
	constexpr char _BOLD_ = 2;
	constexpr char _SIZE_ = 10;
	constexpr double ALPHA = 1.0;
}
using namespace ColorConst;
constexpr bool DRAWING = false;
constexpr bool EXISTED = true;


class Commander ;
class Response
{
protected:
	int X, Y, borderBold, color;
	double alpha;
	static unsigned int count;
	unsigned int id;
public:
	Response() :X(0), Y(0), borderBold(_BOLD_), color(0), alpha(1) {
		id = ++count;
	}
	Response(int x, int y, int Bold, int Color, double Alpha) :X(x), Y(y), borderBold(Bold), color(Color), alpha(Alpha) {
		id=++count;
	}
	~Response() {
		--count;
	}
	virtual int ClickLeft(bool,const MOUSEMSG&) = 0;
    virtual int ClickRight(bool, const MOUSEMSG &) = 0;
    virtual int Suspend() = 0;
    void Move(const int& , const int& );
	int getX() const;
	int getY() const;
	int getID() const;
	double getColor() const;
	double getAlpha() const;
};
class Display
{
protected:
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
protected:
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
	virtual int _Delete();
	virtual void DisplayInfo() const;
	virtual int _Draw(const int &,const int &);
public:
	enum type
	{

	};
	Point(int X, int Y, int Bold, int Color, double Alpha, int Size=_SIZE_) :Response(X, Y, Bold, Color, Alpha), size(Size) {}
	int getSize() const;
	int getType() const;
    virtual int ClickLeft(bool, const MOUSEMSG &);
    virtual int ClickRight(bool, const MOUSEMSG &);
    virtual int Suspend();
};
class Borden :public Display
{
private:
	int termX, termY, bold;
protected:
	virtual int _Draw();
public:
	Borden(int sX,int sY,int tX,int tY,int Bold=_BOLD_):Display(sX,sY),termX(tX),termY(tY),bold(Bold){}
	int getTermX() const;
	int getTermY() const;
	int getBold() const;
	virtual void DisplayInfo() const;
};

class Squareness :public Display
{
private:
	int width, height;
	vector<Text> msg;
	//image
public:
	Squareness(int x, int y, int w, int h) :Display(x, y), width(w), height(h),msg{} {};
	~Squareness() {
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
	int _AddPoint();
	int _DeletePoint();
	int _Bind();
	virtual int _Draw();
	virtual void DisplayInfo() const;
public:
	Polygen(int X, int Y, int Bold, int Color) :Response(X, Y, Bold, Color, ALPHA), points{}, borders{}, area(0), shownedInfo(false) {}
	~Polygen() {
		points.clear();
		borders.clear();
	}
    virtual int ClickLeft(bool, const MOUSEMSG &);
    virtual int ClickRight(bool, const MOUSEMSG &);
    virtual int Suspend();
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
	int _AddPoint();
	int _DeletePoint();
	int _Bind();
	virtual void DisplayInfo() const;
public:
	Line(int X, int Y, int Bold, int Color) :Response(X, Y, Bold, Color, ALPHA), points{}, borders{}, length(0), shownedInfo(false) {}
	~Line() {
		points.clear();
		borders.clear();
	}
    virtual int ClickLeft(bool, const MOUSEMSG &);
    virtual int ClickRight(bool, const MOUSEMSG &);
    virtual int Suspend();
};

class Button :public Response
{
friend class Commander;
private:
	int width, height;
	Text info;
	ButtonType type;
protected:
	virtual int _Draw();
public:
	Button(int X, int Y, int Bold, int Color, int w, int h) :Response(X, Y, Bold, Color, ALPHA), width(w), height(h), type{ NOEXIST_BUTTON } {};
    virtual int ClickLeft(bool, const MOUSEMSG &);
    virtual int ClickRight(bool, const MOUSEMSG &);
    virtual int Suspend();
	int Press(Status,const MOUSEMSG&, vector<Response*>::iterator&);
};

constexpr int ButtonNum = 11;//一共有11个按钮

#endif // !_OBJECTS_H_
