/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-06-11 13:47:16
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-06-11 15:09:06
 * @FilePath: \GIS\Solution.h
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
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

#ifndef _SOLUTION_H_
#define _SOLUTION_H_
extern std::fstream Basic;
extern std::fstream Vec;
class Commander;
void Initialize(const Commander&);
void ShutDown(const Commander&);

#endif // !_SOLUTION_H_

