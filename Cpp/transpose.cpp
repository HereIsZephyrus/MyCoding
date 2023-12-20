/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-11-22 22:17:52
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-11-22 22:24:08
 * @FilePath: \undefinedc:\Users\Administrator\GitHub\MyCoding\Cpp\transpose.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
/*
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-11-22 22:17:52
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-11-22 22:20:30
 * @FilePath: \GitHub\transpose.c
 * @Description:
 *
 * Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#include <stdio.h>

void exchange(int *a, int *b)
{
    int *temp = a;
    a = b;
    b = temp;
}

void transpose(int a[6], int n)
{
    for (int i = 0; i < n - 1; i++)
    {
        for (int j = i + 1; j < n; j++)
        {
            exchange(*(a + i) + j, *(a + j) + i);
        }
    }
}

int main()
{
    int n, a[6][6];
    scanf("%d", &n);
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            scanf("%d", &a[i][j]);
    transpose(a, n);
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
            printf("%d ", a[i][j]);
        printf("\n");
    }
    return 0;
}