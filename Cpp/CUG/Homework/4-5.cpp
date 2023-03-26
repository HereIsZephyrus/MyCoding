#include<iostream>
#include<cmath>
using namespace std;

class myMath{
public:
    static double mysqrt(double);
    static double mysin(double);
    static double myfabs(double);
    static double cicleArea(double);
private:
    static const double PI;
};
 const double myMath::PI=3.1415926;
double myMath::mysqrt(double x){
    return sqrt(x);
}
double myMath::mysin(double x){
    return sin(x);
}
double  myMath::myfabs(double  x)
{  return  fabs(x);}
int  myMath::myfabs(int  x)
{  return  fabs(x);}
double  myMath::circleArea(double  x)
{  return  PI*x*x;}
int fabs(int x){
    return -x;
}
double fabs(double x){
    return -x;
}
int  main()
{  double  x;
    cout<<"input  a  number:";
    cin>>x;
    cout<<"the  result  of  sqrt  is:"<<myMath::mysqrt(x)<<endl;
    cout<<"the  result  of  sin  is:"<<myMath::mysin(x)<<endl;
    cout<<"the  result  of  fabs  is:"<<myMath::myfabs((int)x)<<endl;
    cout<<"the  result  of  fabs  is:"<<myMath::myfabs(x)<<endl;
    cout<<"the  result  of  area  is:"<<myMath::circleArea(x)<<endl;
    return  0;
}