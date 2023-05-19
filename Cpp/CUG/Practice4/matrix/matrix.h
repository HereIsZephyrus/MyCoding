/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-04-30 20:47:12
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-04-30 20:55:10
 * @FilePath: \matrix\matrix.h
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#pragma once
#include<iostream>
#include<cmath>
#include<cassert>
#include<cstring>
#include<cstddef>

template<class Type, size_t Row, size_t Col>
class Matrix{
private:
    Type** mat=nullptr;//Value
    const int row=Row;
    const int col=Col;
public:
    Type** Generate(int,int,const char *);
    Matrix(){
        mat=Generate(row,col,"zeros");
    }
    Matrix(const char *s){
        mat=Generate(row,col,s);
    }
    ~Matrix(){
        for(int i=0;i<row;++i)
            delete[] mat[i];
        delete[] mat;
    }//防止内存溢出
    int getRow() const{return row;}
    int getCol() const{return col;}
    Matrix& operator+(const Matrix& m){
        std::cout<<"Plus"<<std::endl;
        if (row!=m.row||col!=m.col){
            std::cout<<"Error: Matrix size mismatch"<<std::endl;
            return *this;
        }
        for(int i=0;i<row;++i)
            for(int j=0;j<col;++j)
                mat[i][j]=static_cast<Type>(mat[i][j]+m.mat[i][j]);
        return *this;
    }
    Matrix& operator-(const Matrix& m){
        std::cout << "Minus" << std::endl;
        if (row!=m.row||col!=m.col){
            std::cout<<"Error: Matrix size mismatch"<<std::endl;
            return *this;
        }
        for(int i=0;i<row;++i)
            for(int j=0;j<col;++j)
                mat[i][j] = static_cast<Type> (mat[i][j] - m.mat[i][j]);
        return *this;
    }
    Matrix& operator*(const Matrix& m){
        std::cout << "Multiply" << std::endl;
        if (col!=m.row){
            std::cout<<"Error: Matrix size mismatch"<<std::endl;
            return *this;
        }
        Matrix tmp=*this;
        tmp.col=m.getCol();
        tmp.mat=Generate(row,m.col,"zeros");
        for(int i=0;i<row;++i)
            for(int j=0;j<m.col;++j)//矩阵的最终大小为row*m.col
                for(int k=0;k<col;++k)
                    tmp.mat[i][j] += static_cast<Type> (mat[i][k] * m.mat[k][j]);
        return tmp;
    }
    Matrix& operator*(const double d){
        std::cout << "Multiply" << std::endl;
        for(int i=0;i<row;++i)
            for(int j=0;j<col;++j)
                mat[i][j]*=d;
        return *this;
    }
    friend std::ostream& operator<<(std::ostream& os,const Matrix& m){
        for(int i=0;i<m.row;++i){
            for(int j=0;j<m.col;++j)
                os<<m.mat[i][j]<<' ';
            os<<std::endl;
        }
        return os;
    }
    friend std::istream& operator>>(std::istream& is,Matrix& m){
        std::cout<<"Please input the matrix:"<<std::endl;
        m.mat = new Type *[m.row];
        for (int i = 0; i < m.row; ++i)
            m.mat[i] = new Type[m.col];
        for(int i=0;i<m.row;++i)
            for(int j=0;j<m.col;++j)
                is>>m.mat[i][j];
        return is;
    }
};

template <class Type, size_t Row, size_t Col>
Type ** Matrix<Type,Row,Col>::Generate(int col, int row, const char *s){
    Type** tmpMat = new Type *[row];
    for (int i = 0; i < row; ++i)
        tmpMat[i] = new Type[col];
    if(std::strcmp(s,"ones")==0)//生成全1矩阵
        for(int i=0;i<row;++i)
            for(int j=0;j<col;++j)
                tmpMat[i][j]=static_cast<Type>(1);
    else if(std::strcmp(s,"zeros")==0)//生成零矩阵
        for(int i=0;i<row;++i)
            for(int j=0;j<col;++j)
                tmpMat[i][j]=static_cast<Type>(0);
    else if(std::strcmp(s,"eye")==0)
        for(int i=0;i<row;i++)
            for(int j=0;j<col;j++)
                if(i==j)
                    tmpMat[i][j]=static_cast<Type>(1);
                else
                    tmpMat[i][j]=static_cast<Type>(0);
    else{
        std::cout<<"Error: Invalid String"<<std::endl;
        return nullptr;
    }
    return tmpMat;
}