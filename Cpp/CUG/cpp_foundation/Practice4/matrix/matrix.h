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

template<class Type>
class Matrix{
private:
    Type** mat=nullptr;//Value
    int row{1};
    int col{1};
    bool existData{false};
public:
    Type** Generate(int,int,const char *);
    Matrix(int rows,int cols):row(rows),col(cols){
        mat=Generate(row,col,"zeros");
        existData=true;
    }
    Matrix(int rows, int cols,const char *s) :row(rows), col(cols) {
        mat=Generate(row,col,s);
        existData=true;
    }
    ~Matrix(){
        for(int i=0;i<row;++i)
            delete[] mat[i];
        delete[] mat;
        existData=false;
    }//防止内存溢出
    Matrix& operator=(const Matrix& other){
        if (this==&other)
            return *this;
        for(int i=0;i<row;++i)
            delete[] mat[i];
        delete[] mat;
        existData=false;
        row=other.row;
        col=other.col;
        mat=Generate(row,col,"zeros");
        for(int i=0;i<row;++i)
            for(int j=0;j<col;++j)
                mat[i][j]=other.mat[i][j];
        return *this;
    }

    int getRow() const { return row; }
    int getCol() const { return col; }
    Matrix operator+(const Matrix& m) const{
        std::cout<<"Plus"<<std::endl;
        if (row!=m.row||col!=m.col){
            std::cout<<"Error: Matrix size mismatch"<<std::endl;
            return *this;
        }
        Matrix res(row,col);
        for(int i=0;i<row;++i)
            for(int j=0;j<col;++j)
                res.mat[i][j]=static_cast<Type>(mat[i][j]+m.mat[i][j]);
        return res;
    }
    Matrix operator-(const Matrix& m) const{
        std::cout << "Minus" << std::endl;
        if (row!=m.row||col!=m.col){
            std::cout<<"Error: Matrix size mismatch"<<std::endl;
            return *this;
        }
        Matrix res(row,col);
        for(int i=0;i<row;++i)
            for(int j=0;j<col;++j)
                res.mat[i][j] = static_cast<Type> (mat[i][j] - m.mat[i][j]);
        return res;
    }
    Matrix operator*(const Matrix& m) const{
        std::cout << "Multiply" << std::endl;
        if (col!=m.row){
            std::cout<<"Error: Matrix size mismatch"<<std::endl;
            return *this;
        }
        Matrix res(row,m.col);
        for(int i=0;i<row;++i)
            for(int j=0;j<m.col;++j)//矩阵的最终大小为row*m.col
                for(int k=0;k<col;++k)
                    res.mat[i][j] += static_cast<Type> (mat[i][k] * m.mat[k][j]);
        return res;
    }
    Matrix operator*(const double d) const{
        std::cout << "Multiply" << std::endl;
        Matrix res(row,col);
        for(int i=0;i<row;++i)
            for(int j=0;j<col;++j)
                res.mat[i][j]= static_cast<Type>(mat[i][j]*d);
        return res;
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
        std::cout<<"Please input the matrix("<<m.getRow()<<'*'<<m.getCol()<<"):"<<std::endl;
        if (!m.existData)
            m.Generate(m.row,m.col,"zeros");
        for(int i=0;i<m.row;++i)
            for(int j=0;j<m.col;++j)
                is>>m.mat[i][j];
        return is;
    }
};

template <class Type>
Type ** Matrix<Type>::Generate(int col, int row, const char *s){
    if (existData) {
        for(int i=0;i<row;++i)
            delete[] mat[i];
        delete[] mat;
    }
    Type** tmpMat = new Type *[row];
    for (int i = 0; i < row; ++i)
        tmpMat[i] = new Type[col];
    if(std::strcmp(s,"zeros")==0)//生成零矩阵
        for(int i=0;i<row;++i)
            for(int j=0;j<col;++j)
                tmpMat[i][j]=static_cast<Type>(0);
    else if(std::strcmp(s,"ones")==0)//生成全1矩阵
        for(int i=0;i<row;++i)
            for(int j=0;j<col;++j)
                tmpMat[i][j]=static_cast<Type>(1);
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
    existData=true;
    return tmpMat;
}