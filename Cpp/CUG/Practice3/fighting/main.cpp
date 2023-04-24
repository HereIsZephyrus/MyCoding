#include<iostream>
#include<cmath>
#include<ctime>
#include<vector>
#include<windows.h>
#include "Setting.h"

constexpr int SLEEPTIME=500;//睡眠时间，用于控制输出速度
void Guidance();//游戏引导
void Background();//游戏背景
std::string getName();//获取玩家姓名
char getChoice();//获取玩家选择
Monster finalBoss("Alsace",1000,1000,1000);//最终boss，用于生成静态成员（说不定会出现）
//auto p = finalBoss.getRandomMonster(); // 试图解决一个奇怪的BUG
int main(){
    srand((unsigned)time(NULL));//随机种子
    std::vector<Document> players;//玩家注册列表
    std::string name=getName();//获取玩家姓名
    Guidance();//游戏引导
    while (name!="quit"){//游戏主循环
        int index=0;//玩家在注册列表中的位置
        //system("pause");
        Player player(name);//创建玩家实例
        for (auto it=players.begin();it!=players.end();++it){//遍历注册列表
            if (it->getName()==name){
                std::cout << "Welcome back,brave!Let's start again!" << std::endl;
                int winCount=it->getWinCount(),gold=it->getGold();
                break;
            }
            ++index;
        }
        //system("pause");
        if (index==players.size()){//如果玩家未注册过
            Background();//向新玩家介绍游戏背景
            std::cout << "Welcome "<<name<<"!let's start your adventure!" << std::endl;
            players.push_back(Document(name));//将新玩家注册到注册列表中
            Sleep(SLEEPTIME);
        }

        player.display();//显示玩家信息
        while (player.alive() && player.getLevel() < 20){//玩家存活且等级未达到20级时游戏继续
            std::cout << std::endl<< std::endl<< std::endl;
            //system("pause");
            //Monster monster(finalBoss.getRandomMonster());                           // 生成怪物
            Monster monster;
            std::cout<< "You have encountered a " << monster.getName() << std::endl;//提示玩家遇到的怪物类型
            monster.display();//显示怪物信息
            Sleep(SLEEPTIME);
            bool isFled=false;
            while (!isFled && monster.alive() && player.alive()){
                std::cout<<"(R)un or (F)ight?" << std::endl;//提示玩家选择
                char choice=getChoice();//获取玩家选择
                switch (choice){
                    case 'R':{//玩家选择逃跑
                        bool runSuccess=(rand()%10>=5);//逃跑成功的概率为50%
                        if (runSuccess){//逃跑成功
                            std::cout << "You successfully fled" << std::endl;
                            isFled=true;
                            break;
                        }
                        else{
                            std::cout << "You failed to flee!" << std::endl;
                            monster.Attack(player);//怪物攻击玩家
                            break;
                        }
                        break;
                    }
                    case 'F'://玩家选择战斗
                        player.Attack(monster);
                        Sleep(SLEEPTIME);
                        if (monster.alive())
                            monster.Attack(player);
                        Sleep(SLEEPTIME);
                        break;
                }
            }
            if (!isFled && player.alive()){//如果玩家没有逃跑且存活
                player.LevelUp();//玩家升级
                player.Fatch(monster.Contain());//玩家获得怪物掉落金币
                Sleep(SLEEPTIME);
            }
        }
        if (player.alive()){//如果玩家最终存活
            std::cout << "You win!Congratulations, breave!" << std::endl;
            Sleep(SLEEPTIME);
            players[index].Win(player.Contain());//玩家获得胜利,将玩家该局获得的金币存入注册列表
        }
        else{
            std::cout << "Wasted!" << std::endl;//玩家死亡
            player.wastedStatus();//显示玩家死亡时的信息
            players[index].Lose();//玩家失败次数加一
        }
        players[index].HonourCount();//显示玩家生涯统计
        name=getName();//获取新一轮游戏的玩家姓名
    }
    return 0;
}
void Guidance(){

}
void Background(){

}
std::string getName(){
    std::string name;
    std::cout << "A new game?" << std::endl;
    std::cout << "Please enter your name(quit):" << std::endl;
    std::cin >> name;
    return name;
}
char getChoice(){
    char choice;
    choice=getchar();
    choice = toupper(choice);
    while (choice!='R' && choice!='F')
        choice = getchar();
    return choice;
}