/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-05-01 18:19:10
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-05-01 20:09:36
 * @FilePath: \blackjackc:\Users\Administrator\GitHub\MyCoding\Cpp\CUG\Cleanance202305\main.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-05-01 18:19:10
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-05-01 18:32:57
 * @FilePath: \blackjackc:\Users\Administrator\GitHub\MyCoding\Cpp\CUG\Cleanance202305\main.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
/*
	程序名称：扫雷

	简　　介：一款经典的小游戏，程序运行中可以通过 ESC 直接退出
			　左键点击，右键标记和取消标记，同时按下左右或按下中间键触发提示
			　其他操作基本和官方一致，界面略有调整，详细操作自行测试

	编译环境：VS2019 + EasyX_20190529(beta)

	编写时间：2019-6-29
	最后修改：2019-7-30

	作　　者：Teternity(qq1926594835)

	版　　权：作者原创，无抄袭，不涉及版权问题，仅用作学习
*/
#include "gragh.h"
#include "MineSweeper.h"
//int graphSize = static_cast<int>(Primary);
int main(){
    long	ret = 0;
    srand((unsigned)time(0));
    MineSweeper *ms = new MineSweeper(0);//primary
    while (true){
        int size = ms->Running();
        if (size > 0){
            delete ms;
            ms = new MineSweeper(size);
        }
        else
            break;
    }
    delete ms;
    ret = _getwch();
    return 0;
    }
