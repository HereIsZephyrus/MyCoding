/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-06-07 20:53:55
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-06-08 13:59:55
 * @FilePath: \GIS\main.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */

#include "Solution.h"
#include "Objects.h"
#include "Errors.h"
#include "Commander.h"

int main(int argc,char *argv[]) {
    Commander cmder;
	Initialize(cmder);
    bool bExit = false;
    
    while (!bExit)
    {
        system("pause");
        switch (cmder.getCommand())//异常控制
        {
            case 0: {
                ShutDown(cmder);
                bExit = true;
                break;
            }
            case -1: {
                //failed
                break;
            }
            default: {

                bExit = true;
                break;
            }
        }
        system("pause");
    }
	ShutDown(cmder);
	return 0;
}


