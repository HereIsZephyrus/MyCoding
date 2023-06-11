/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-06-08 13:51:29
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-06-09 11:02:18
 * @FilePath: \GIS\Solution.h
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#pragma once
#include<graphics.h>
#include<conio.h>
#include<fstream>
#include<iostream>
namespace streaming {
    using std::fstream;
    using std::ostream;
    using std::istream;
    using std::endl;
    using std::cin;
    using std::cout;
}
#ifndef _SOLUTION_H_
#define _SOLUTION_H_
using namespace streaming;
fstream Basic;
fstream Vec;
void Initialize();
void ShutDown();

#endif // !_SOLUTION_H_

