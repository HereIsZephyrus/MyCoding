/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-05-06 22:17:58
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-05-06 22:18:09
 * @FilePath: \Homework\7-2.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#include<iostream>
#include<iomanip>
#include<algorithm>
#include<cstring>
#include<vector>

struct Student{
    int score;
    std::string name;
};

int main(){
    std::vector<Student> students;
    int n;
    std::cin >> n;
    for (int i = 0; i < n; i++){
        Student s;
        std::cin >> s.name >> s.score;
        students.push_back(s);
    }
    std::sort(students.begin(), students.end(), [](Student a, Student b){
        return a.score > b.score;
    });
    for (auto s : students){
        std::cout << std::setw(15) << s.name << std::setw(5) << s.score << std::endl;
    }
    std::cin.get();
    std::cin.get();
    return 0;
}