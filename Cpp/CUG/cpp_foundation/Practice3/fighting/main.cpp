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
int main(){
    srand((unsigned)time(NULL));//随机种子
    std::vector<Document> players;//玩家注册列表
    Guidance();                   // 游戏引导
    std::string name=getName();//获取玩家姓名
    while (name!="quit"){//游戏主循环
        unsigned int index=0;//玩家在注册列表中的位置
        //system("pause");
        Player player(name);//创建玩家实例
        for (auto it=players.begin();it!=players.end();++it){//遍历注册列表
            if (it->getName()==name){
                (*it).HonourCount();//显示玩家生涯统计
                std::cout << "Welcome back,brave!Let's start again!" << std::endl;
                //int winCount=it->getWinCount(),gold=it->getGold();
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
                if (rand()%3<=1){
                    Potion potion;
                    std::cout << "You found a "<<potion.getSize()<<" Potion!" << std::endl;
                    if (player.is_recognized(potion.indexType()))//玩家能否识别药水
                        std::cout << "It is a !"<<potion.getType() << std::endl;
                    else
                        std::cout << "But you don't know what is it...Have a try?" << std::endl;
                    Sleep(SLEEPTIME);
                    std::cout << "Do you want to Drink it?(Y/N)";
                    char choice=getChoice();
                    if (choice=='Y'){
                        player.RecognizePotion(potion.indexType());//玩家识别药水类型
                        potion.Drinked(player);
                        Sleep(SLEEPTIME);
                    }
                }
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
    std::cout<<R"(
    Welcome to the game!
    You are a brave adventurer who is going to fight with monsters.
    You can choose to run or fight with the monster.
    If you choose to run, you have 50% chance to escape.
    If you choose to fight, you will attack the monster first.
    If you win, you will get the gold the monster contains.
    If you lose, you will lose your life.
    )";
}
void Background(){
    std::cout<<"新来的冒险者，欢迎来到交界地！"<<std::endl;
    Sleep(SLEEPTIME*10);
    std::cout << R"(
    但是《原神》是由米哈游自主研发的一款全新开放世界冒险游戏。游戏发生在一个被称作「提瓦特」的幻想世界，在这里，被神选中的人将被授予「神之眼」，导引元素之力。你将扮演一位名为「旅行者」的神秘角色
在自由的旅行中邂逅性格各异、能力独特的同伴们，和他们一起击败强敌，找回失散的亲人——同时，逐步发掘「原神」的真相。
因为你的素养很差，我现在每天玩原神都能赚150原石，每个月差不多5000原石的收入， 也就是现实生活中每个月5000美元的收入水平，换算过来最少也30000人民币，虽然我 只有14岁，但是已经超越了中国绝大多数人(包括你)的水平，这便是原神给我的骄傲的资 本。
毫不夸张地说，《原神》是miHoYo迄今为止规模最为宏大，也是最具野心的一部作品。即便在经历了8700个小时的艰苦战斗后，游戏还有许多尚未发现的秘密，错过的武器与装备，以及从未使用过的法术和技能。
尽管游戏中的战斗体验和我们之前在烧机系列游戏所见到的没有多大差别，但游戏中各类精心设计的敌人以及Boss战已然将战斗抬高到了一个全新的水平。就和几年前的《 塞尔达传说 》一样，《原神》也是一款能够推动同类游戏向前发展的优秀作品。
    )";
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
    while (choice!='R' && choice!='F' && choice!='Y' && choice!='N')
        choice = getchar();
    return choice;
}