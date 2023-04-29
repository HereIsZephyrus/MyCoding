/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-04-22 17:47:49
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-04-29 14:17:30
 * @FilePath: \fraction\main.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-04-22 17:47:49
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-04-22 17:47:59
 * @FilePath: \Practice3\fraction\main.cpp
 * @Description:
 * @分数类的主程序
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#include <iostream>
#include "fraction.h" // class fraction

using namespace std;
int main(){
    fraction f1(1, 2); // 表示1/2
    fraction f2(1.2, 0.5); // 表示1.2/0.5
    fraction f3(0.6); //转换为分数3/5
    fraction f4;
    fraction f5 = f3; //拷贝构造
    cin >> f4; //输入分子，分母，并简化
    cout << f1 + f2 << endl;
    cout << f1 - f2 << endl;
    cout << f1 * f2 << endl;
    cout << f1 / f2 << endl;
    cout << f3 + 0.5 << endl; // -*/都支持
    cout << 0.5 + f3 << endl; // -*/都支持
    cout << f4 + 1 << endl;
    cout << 1 + f4 << endl;
    cout << double(f5) << endl;
    cout << double(f5) + 0.5 << endl;
    cin.get();
    cin.get();
    return 0;
}