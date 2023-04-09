/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-04-09 22:46:56
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-04-09 23:13:33
 * @FilePath: \undefinedc:\Users\Administrator\GitHub\MyCoding\Cpp\CUG\Homework\5-4.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-04-09 22:46:56
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-04-09 22:47:12
 * @FilePath: \Homework\5-4.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#include<iostream>

int main(){
    char c;
    int count=0;
    c=getchar();
    while (c!=EOF && c!='\n' && c!='\r' && c!='\0'){
        c=getchar();
        if(c==' ')    count++;
    }
    std::cout<<count+1;
    std::cin.get();
    std::cin.get();
    return 0;
}