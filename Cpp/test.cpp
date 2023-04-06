/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-04-05 19:33:40
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-04-05 19:40:47
 * @FilePath: \Homeworkc:\Users\Administrator\GitHub\MyCoding\Cpp\test.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
// 滤波.cpp : 此文件包含 "main" 函数。程序执行将在此处开始并结束。
//生成一个随机数矩阵（可以设置的大一些），随机数的范围是0 - 255.
//程序可以进行滤波操作，其中滤波核大小和值由用户进行设置。
#include<iostream>
#include<iomanip>
#include<random>
using namespace std;
float** ARRAY(int row, int column);
float** Array3(int row, int column);

int main() {
	int row, column;
	cin >> row >> column;
	float** Matrix1 = ARRAY(row,column);
	float** Matrix3 = Array3(row, column);
	float arr0[3][3] =
	{
		{1.0 ,1.0 ,1.0},
		{1.0 ,1.0 ,1.0},
		{1.0 ,1.0 ,1.0}
	};
	//进行滤波操作
	float num1 = 0;
	float num2 = 0;
	for (int n = 1; n < row; n++)
	{
		for (int m = 1; m < column; m++)
		{
			float sum = 0;
			for (int i = - 1; i < 1; i++)
			{
				for (int j = -1; j < 1; j++)
				{
					num1 = Matrix3[n+i][m+j];
					num2 = arr0[i+1][j+1];
					sum += num1 * num2;
				}
			}
			Matrix1[n ][m] = sum/9;
		}
	}
	for (int i = 1; i < row + 1; i++) {
		for (int j = 1; j < column + 1; j++)
		{
			cout << setw(5) << Matrix1[i][j];
		}
		cout << "\n";//打印
	}

	return 0;

}

float** ARRAY(int row, int column) {
	random_device rd;//随机数发生器
	mt19937 Random(rd());
	int i, j;
	float** Matrix1;//双指针
	//Matrix1 = new float* [row + 2];
	for (int a = 0; a < row + 2; a++)
		Matrix1[a] = new float[column + 2];//指针数组的每个元素指向每个int型数组的第一个元素地址，实现了二维数组的创建，在这里往外扩张了一圈用于填0元素
	for (i = 0; i < row + 2; i++)
	{
		for (j = 0; j < column + 2; j++)
		{
			if (i == 0 || j == 0 || i == row + 1 || j == column + 1) {
				Matrix1[i][j] = 0;
			}
			else { Matrix1[i][j] = (float)(rd() % 255 + 1); }//rand的范围在[0,255]内
		}
	}
	return Matrix1;
}//创建二维数组，并用随机数初始化每个元素的值，扩展了最外圈且元素值为0
float** Array3(int row, int column) {
	float** Matrix3;
	//Matrix3 = new float* [row + 2];
	for (int a = 0; a < row + 2; a++)
		Matrix3[a] = new float[column + 2];
	for (int i = 0; i < row + 2; i++)
	{
		for (int j = 0; j < column + 2; j++) {
			Matrix3[i][j] = Matrix1[i][j];
		}
	}
	return Matrix3;
}//创建数组2，作为数组1的备份