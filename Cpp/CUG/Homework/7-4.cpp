/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-05-06 22:35:26
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-05-06 22:36:06
 * @FilePath: \Homework\7-4.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#include <iostream>

template <typename T>
static void Swap(T& a, T& b){
    T c(a);
    a = b;
    b = c;
}

//bubble
template <typename T>
static void Bubble(T array[], int len, bool min2max = true){
    for(int i = 0; i<len; i++)
        for(int j = len-1; j>i; j--)
            if(min2max ? (array[j]<array[j-1]) : (array[j] > array[j-1]))
                Swap(array[j], array[j-1]);
}

int main(){
    int array[] = {9,7,2,4,3,4,6,5,8,9};

    Bubble(array, 10, true);

    for(int i=0; i<10; i++)
        std::cout << array[i] << std::endl;
    std::cout << std::endl;
    Bubble(array, 10, false);

    for(int i=0; i<10; i++)
        std::cout << array[i] << std::endl;

    return 0;
}