# -*- coding: utf-8 -*-
"""
Created on Tue Nov 21 10:35:42 2022

@author: Yangxue_z
"""

# 课程：计算科学基础（课后实践练习）
# 实践内容：设计生命游戏，完成cellular.py的代码编写

############### 答题者信息-开始 ###############
# 姓名：童川博
# 学号：20221000679
# 合作者（如有）：
############### 答题者信息-结束 ###############


# 元胞自动机--生命游戏
############### 帮助代码-开始 ###############

import os
import copy
import time 
from random import random

#系统指定生命空间的大小，也即：6行；6列
#width=6
#hight=6
SignalTuple=(' · ',' ◎ ')
SignalDictionary={'Dead':SignalTuple[0],'Live':SignalTuple[1]}
LiveCount=[]

def init(maxn,proportion):
    """
    初始化游戏，以life_prob的概率生成活细胞
    输入：life_prob——生成活细胞的概率
    输出：width x height大小的细胞状态
    """   
    Res_Space=[]

    Row_TopBoard=[]
    Row_TopBoard.append('┌')
    for i in range(maxn):
        Row_TopBoard.append('———')
    Row_TopBoard.append('┐')
    Res_Space.append(Row_TopBoard)

    for i in range(maxn):
        Row_Space=[]
        Row_Space.append('|')
        for j in range(maxn):
            Row_Space.append(SignalTuple[proportion>random()*10])
        Row_Space.append('|')
        Res_Space.append(Row_Space)

    Row_BottonBoard=[]
    Row_BottonBoard.append('└')
    for i in range(maxn):
        Row_BottonBoard.append('———')
    Row_BottonBoard.append('┘')
    Res_Space.append(Row_BottonBoard)
    Res_Universe={'space':Res_Space,'size':maxn,'evolve':True}
    for i in range(1,maxn+1):
        for j in range(1,maxn+1):
            LiveCount.append(get_near_by_cells_count(Res_Universe,i,j))
    return Res_Space

def print_space(Space,minn,maxn):
    """ 
    space 参数类型与init()函数返回值类型一致，表示当前
    细胞状态。由于屏幕打印时行距比字符宽度大很多，所以请在打印
    每个字符后面加空格，并在最后一个字符的后面打印'|'表示生命
    空间的边界(注意：表示生命空间边界的符号可以换成你们喜欢的符号，不局限
    于'|')
    """
    for i in range(minn,maxn):
        Row=Space[i]
        print(''.join(Row[minn:maxn]))

def get_near_by_cells_count(universe, x, y):
    """
    get_near_by_cells_count()的形参有：space, i,j；
    其中space与init()函数的返回值类型一致，表示当前细胞的状态；
    i和j均为int类型，表示生命空间各细胞,也即：n*n空间内的格子，所在的行号和列号
    函数返回值为int类型，表示位置(i，j)的细胞其相邻活细胞的数量
    """
    Count=0
    for i in (x-1,x,x+1):
        for j in (y-1,y,y+1):
            if universe['space'][i][j]==SignalDictionary['Live']:
                Count+=1
#            print(i,j,universe['space'][i][j],Count)
    if universe['space'][x][y]==SignalDictionary['Live']:
        Count-=1
#    print(x,y,Count)
#    input()
    return Count

def EvolveCheck(universe):
    EvolveFlag=False
    for i in range(1,universe['size']+1):
        for j in range(1,universe['size']+1):
            NearCount=get_near_by_cells_count(universe,i,j)
            if  universe['space'][i][j]==SignalDictionary['Live'] and NearCount!=LiveCount[universe['size']*(i-1)+j-1] :
                EvolveFlag=True
                LiveCount[universe['size']*(i-1)+j-1]=NearCount 
    return EvolveFlag
def update(universe):
    """
    该函数包含一个参数，space，其类型与init()函数返回值类型一致，表示当前
    细胞状态。该函数根据传入生命空间space内细胞的状态，利用更新原则对细胞
    状态进行更新，并返回更新后的细胞状态，返回值类型与space类型一致
    
    """
    NewSpace=copy.deepcopy(universe['space'])
    for i in range(1,universe['size']+1):
        NewRow=copy.deepcopy(universe['space'][i])
        #CountRow=[]
        for j in range(1,universe['size']+1):
            NearCount=get_near_by_cells_count(universe,i,j)
        #    match (NearCount):
        #        case 3:
        #            NewRow[j]=SignalDictionary['Live']
        #            break
        #        case 2:
        #            break
        #        case _:
        #            NewRow[j]=SignalDictionary['Dead']
            if NearCount==3:
                NewRow[j]=SignalDictionary['Live']
            elif NearCount!=2:
                NewRow[j]=SignalDictionary['Dead']
            #CountRow.append(str(NearCount))
        NewSpace[i]=copy.deepcopy(NewRow)
        #print(''.join(CountRow))
    return {'space':NewSpace,'size':universe['size']}

def DistinctionCheck(universe):
    for i in range(1,universe['size']+1):
        Row=universe['space'][i]
        for j in range(1,universe['size']+1):
            if Row[j]==SignalDictionary['Live']:
                return False
    return True
def SlientCheck(OldUniverse):
    NextUnverse=copy.deepcopy(OldUniverse)
    NextUnverse=update(NextUnverse)
    if NextUnverse==OldUniverse:
        return True
    return False
def TerminalCheck(universe):
    if DistinctionCheck(universe):
        return "Distinct"
    if SlientCheck(universe):
        return "Slient"
    return "Circulate"

def prework():
    """
    This fuction is aiming to load preliminary parameters and show the UI
    """
    Size=int(input("Please input the Size of the space:"))
    Proportion=int(input("Please input a number between 0 and 10 that measure the proportion of survival:"))
    Space=init(Size,Proportion)
    os.system("cls")
    print_space(Space,0,Size+2)
    return {'space':Space,'size':Size}

def start():
    """
    (1)游戏开始后，用户输入活细胞的概率：life_prob的值，并调用辅助函数1 
    实现生命空间内细胞状态的随机生成
    (2)根据辅助函数1生成的细胞状态，调用辅助函数2，将当前细胞的状态进行打印
    (3)实现人机互动，如果按q键则结束游戏；如果按其他键则继续游戏
    (4)提示：如果要继续游戏，则需要对细胞生命状态进行更新，也即需要调用辅助函数3；
    并判断细胞生命状态更新前后差异，如果没有变化则终止游戏
    """

    ##以下代码实现了输入任意键游戏开始功能
    os.system("cls") # 用于清空窗口之前打印的内容
    print('==== 元胞自动机 ====')
    print('作者：童川博\n')
    print('按下任意键开始游戏...')
    os.system("pause")
    os.system("cls")
    Universe=prework()

    while (input('''Please enter to continue and input 'q' to exit''')!='q'):
        Universe=update(Universe)
        os.system("cls")
        print_space(Universe['space'],0,Universe['size']+2)
        if EvolveCheck(Universe)==False:
            flag=TerminalCheck(Universe)
            match (flag):
                case "Distinct":
                    print("The universe is dead!Game over.\n")
                    break
                case "Slient":
                    print("The Universe is immortal...But fall slient.")
                    break
                case "Circulate":
                    for i in range(5):
                        Universe=update(Universe)
                        os.system("cls")
                        print_space(Universe['space'],0,Universe['size']+2)
                        print("The Universe is immortal...But a little monotonous.")
                        time.sleep(1)
                    break
            time.sleep(4)
            break


###以下为主程序的测试代码
if __name__ == "__main__":
    
    # 以下为start()函数的测试代码
    start()



