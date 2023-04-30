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

template<class Type, int Row, int Col>
class Matrix{
private:
    Type** mat=nullptr;
    const int row=Row;
    const int col=Col;
public:
    Type** Generate(int,int,const char *);
    Matrix()=delete;
    Matrix(const char *s="zeros"){
        mat=Generate(row,col,s);
    }
    ~Matrix(){
        for(int i=0;i<row;++i)
            delete[] mat[i];
        delete[] mat;
    }
    Matrix& operator+(const Matrix& m){
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
        if (col!=m.row){
            std::cout<<"Error: Matrix size mismatch"<<std::endl;
            return *this;
        }
        Matrix<Type,row,m.col> tmp("zeros");
        for(int i=0;i<row;++i)
            for(int j=0;j<m.col;++j)//矩阵的最终大小为row*m.col
                for(int k=0;k<col;++k)
                    tmp.mat[i][j] += static_cast<Type> (mat[i][k] * m.mat[k][j]);
        return tmp;
    }
    Matrix& operator*(const double& d){
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
        m.mat = new Type *[m.row];
        for (int i = 0; i < m.row; ++i)
            m.mat[i] = new Type[m.col];
        for(int i=0;i<m.row;++i)
            for(int j=0;j<m.col;++j)
                is>>m.mat[i][j];
        return is;
    }
};

template <class Type, int Row, int Col>
Type ** Matrix<Type,Row,Col>::Generate(int col, int row, const char *s){
    Type** tmpMat = new Type *[row];
    for (int i = 0; i < row; ++i)
        tmpMat[i] = new Type[col];
    if(std::strcmp(s,"ones")==0)
        for(int i=0;i<row;++i)
            for(int j=0;j<col;++j)
                tmpMat[i][j]=static_cast<int>(1);
    else if(std::strcmp(s,"zeros")==0)
        for(int i=0;i<row;++i)
            for(int j=0;j<col;++j)
                tmpMat[i][j]=static_cast<int>(0);
    else if(std::strcmp(s,"eye")==0)
        for(int i=0;i<row;i++)
            for(int j=0;j<col;j++)
                if(i==j)
                    tmpMat[i][j]=static_cast<int>(1);
                else
                    tmpMat[i][j]=static_cast<int>(0);
    else{
        std::cout<<"Error: Invalid String"<<std::endl;
        return nullptr;
    }
    return tmpMat;
}