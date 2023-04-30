#pragma once
#include<iostream>

class Shape{
protected:
    double area;
    double perimeter;
public:
    Shape():area(0),perimeter(0){}
    virtual ~Shape()=default;
    virtual std::istream& read(int* argu);//一个抽象的shape类无法有构造的行为
    std::ostream& write(std::ostream& os){
        os<<"Area: "<<area<<std::endl;
        os<<"Perimeter: "<<perimeter<<std::endl;
        return os;
    }
    std::ostream& operator<<(std::ostream& os){
        return write(os);
    }
};

class Triangle:public Shape{
private:
    double a,b,c;
    double calcArea() const{
        double p=(a+b+c)/2;
        return sqrt(p*(p-a)*(p-b)*(p-c));
    }
    double calcPerimeter() const{
        return a+b+c;
    }
public:
    Triangle():a(0),b(0),c(0){}
    Triangle(int* arg):a(arg[0]),b(arg[1]),c(arg[2]){
        area=calcArea();
        perimeter=calcPerimeter();
    }
    ~Triangle()=default;
    int* read(std::istream& is){
        int* arg=new int[3];
        is>>arg[0]>>arg[1]>>arg[2];
        return arg;
    }
};
class Rectangle:public Shape{
private:
    double a,b;
    double calcArea() const{
        return a*b;
    }
    double calcPerimeter() const{
        return 2*(a+b);
    }
public:
    Rectangle():a(0),b(0){}
    Rectangle(int* arg):a(arg[0]),b(arg[1]){
        area=calcArea();
        perimeter=calcPerimeter();
    }
    ~Rectangle()=default;
    int* read(std::istream& is){
        int* arg=new int[2];
        is>>arg[0]>>arg[1];
        return arg;
    }
};
class Square:virtual public Rectangle{
private:
    double a;
    double calcArea() const{
        return a*a;
    }
    double calcPerimeter() const{
        return 4*a;
    }
public:
    Square():a(0){}
    Square(int* arg):a(arg[0]){
        area=calcArea();
        perimeter=calcPerimeter();
    }
    ~Square()=default;
    int* read(std::istream& is){
        int* arg=new int[1];
        is>>arg[0];
        return arg;
    }
};
class Ellipse:public Shape{
private:
    double a,b;
    double calcArea() const{
        return a*b*3.14;
    }
    double calcPerimeter() const{
        return 2*3.14*sqrt((a*a+b*b)/2);
    }
public:
    Ellipse():a(0),b(0){}
    Ellipse(int* arg):a(arg[0]),b(arg[1]){
        area=calcArea();
        perimeter=calcPerimeter();
    }
    ~Ellipse()=default;
    int* read(std::istream& is){
        int* arg=new int[2];
        is>>arg[0]>>arg[1];
        return arg;
    }
};
class Circle:virtual public Ellipse{
private:
    double r;
    double calcArea() const{
        return r*r*3.14;
    }
    double calcPerimeter() const{
        return 2*r*3.14;
    }
public:
    Circle():r(0){}
    Circle(int* arg):r(arg[0]){
        area=calcArea();
        perimeter=calcPerimeter();
    }
    ~Circle()=default;
    int* read(std::istream& is){
        int* arg=new int[1];
        is>>arg[0];
        return arg;
    }
};