/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-05-06 22:48:57
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-05-06 22:49:28
 * @FilePath: \Homework\7-3.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#include  <iostream>
#include  <iomanip>
using  namespace  std;

//  myArrayList  template  class
template  <typename  ElemType>
class  myArrayList{
private:
        int  mSize;
        int  mLen;
        ElemType  *mpArr;
public:
        myArrayList(int  n);
        myArrayList(ElemType  *a,  int  n);
        void  show();
        ElemType  getMax();
        void  sort();
        myArrayList(int n){
            mSize = n;
            mLen = 0;
            mpArr = new ElemType[mSize];
        }
        myArrayList(ElemType *a, int n){
            mSize = n;
            mLen = n;
            mpArr = new ElemType[mSize];
            for (int i = 0; i < mLen; i++)
                mpArr[i] = a[i];
        }
        void sort(){
            for (int i = 0; i < mLen; i++)
                for (int j = 0; j < mLen - i - 1; j++){
                    if (mpArr[j] > mpArr[j + 1])
                        ElemType temp = mpArr[j];
                        mpArr[j] = mpArr[j + 1];
                        mpArr[j + 1] = temp;
            }
        }
};
template<typename  ElemType>
myArrayList<ElemType>::myArrayList(myArrayList<ElemType>  &other)
{
        this->mLen  =  other.mLen;
        this->mSize  =  other.mSize;
        this->mpArr  =  new  ElemType[this->mLen];
        for  (int  i  =  0;  i  <  this->mLen;  i++)
        this->mpArr[i]  =  other.mpArr[i];
}

template<typename  ElemType>
myArrayList<ElemType>::myArrayList(int  n)
{
        this->mSize  =  n;
        this->mLen  =  0;
        this->mpArr  =  new  ElemType[mSize];
}

//*************************************
template  <typename  ElemType>
void  myArrayList<ElemType>::show()
{
        for  (int  i  =  0;  i  <  mLen;  i++)
        cout  <<  mpArr[i]<<"      ";//三个空格
        cout  <<  endl;
}

template  <typename  ElemType>
ElemType  myArrayList<ElemType>::getMax()
{
        ElemType    max;
        max  =  mpArr[0];
        for  (int  i  =  1;  i  <  mLen;  i++)
        if  (max  <  mpArr[i])
        max  =  mpArr[i];
        return  max;
}

class  Student
{
private:
        int  mId;
        float  height;
        int  score;
public:
        Student(int  id  =  0,  float  h  =  0,  int  s  =  0)  :height(h),  mId(id),  score(s)  {  }
};

int  main()
{
        int  a[]  =  {  1,  2,  3,  5,  7,  9,  12,  8  };
        double    b[]  =  {  1,  2.5,  3.6,  5,  7,  9,  12.8,  8  };
        myArrayList  <int>  list1(a,  8);
        list1.sort();
        list1.show();
        cout  <<  "max="  <<  list1.getMax()  <<  endl;

        myArrayList  <double>  list2(b,  8);
        list2.sort();
        list2.show();
        cout  <<  "max="  <<  list2.getMax()  <<  endl;
        Student  s[3]  =  {  Student(1,  175,  80),  Student(2,  178,  90),  Student(3,  195,  83)  },  s1;

        myArrayList  <Student>  list3(s,  3);
        list3.sort();
        list3.show();
        cout  <<  "max="<<list3.getMax()<<  endl;
}