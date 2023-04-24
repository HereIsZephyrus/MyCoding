/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-04-23 20:28:18
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-04-23 20:29:58
 * @FilePath: \fighting\Setting.h
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#pragma once
#include<string>
#include<iostream>

constexpr int MAX_MONSTER_TYPES=3;
class Document{
private:
    std::string name;
    int winCount = 0;
    int loseCount = 0;
    int gold = 0;

public:
    Document() = delete; // 禁止默认构造函数
    Document(std::string Name) : name{Name}, winCount{0}, loseCount{0} {}
    ~Document() {}
    void HonourCount(){ // 显示玩家战绩
        std::cout << "Hi," << name << "!You have won " << winCount << " times and lost " << loseCount << " times." << std::endl;
        std::cout << "And your gold contain:" << gold << std::endl;
    }
    void Win(int goldFetch){ // 胜利后更新战绩
        ++winCount;
        gold += goldFetch;
    }
    void Lose(){ // 失败后更新战绩
        ++loseCount;
    }
    std::string getName(){
        return name;
    }
    int getWinCount(){
        return winCount;
    }
    int getGold(){
        return gold;
    }
};
class Creature{
    protected:
        int health;
        int money;
        int damage;
        std::string name;
    public:
        Creature()=delete;
        Creature(std::string Name,int Health,int Money,int Attack):name{Name},health{Health},money{Money},damage{Attack}{}
        ~Creature(){}
        void display(){
            std::cout << "Name:" << name << std::endl;
            std::cout << "Health:" << health << std::endl;
            std::cout << "Money:" << money << std::endl;
            std::cout << "Damage:" << damage << std::endl;
        }
        void Attack(Creature &target){//攻击目标
            target.health-=damage;
            std::cout<<name<<" hit the "<<target.name<<" for "<<damage<<" damage."<<std::endl;
            if (target.health<=0)//如果目标死亡
                std::cout<<target.name<<" is dead."<<std::endl;
            else
                std::cout<<target.name<<" has "<<target.health<<" health left."<<std::endl;
        }
        bool alive(){
            return health>0;
        }
        int Contain(){
            return money;
        }
        int getAttack(){
            return damage;
        }
        int getHealth(){
            return health;
        }
        std::string getName(){
            return name;
        }
};
class Monster: public Creature{
    private:
        const std::string typeString[MAX_MONSTER_TYPES]={"dragon","orc","slime"};
        const int typeHealth[MAX_MONSTER_TYPES]={20,4,1};
        const int typeMoney[MAX_MONSTER_TYPES]={100,25,10};
        const int typeAttack[MAX_MONSTER_TYPES]={4,2,1};
        const char typeSymbol[MAX_MONSTER_TYPES]={'D','O','S'};
    public:
        enum MonsterType{
            DRAGON,
            ORC,
            SLIME,
            MAX_MONSTER_TYPES
        };
        Monster():Creature("Default",1,0,1){
            MonsterType tmpType = static_cast<MonsterType>(rand() % MAX_MONSTER_TYPES);
            name = typeString[tmpType];
            health = typeHealth[tmpType];
            money = typeMoney[tmpType];
            damage = typeAttack[tmpType];
        }
        Monster(MonsterType type):Creature(typeString[type],typeHealth[type],typeMoney[type],typeAttack[type]){}
        Monster(std::string Name, int Health, int Money, int Attack) : Creature(Name,Health,Money,Attack) {}
        static MonsterType getRandomMonster(){
            return static_cast<MonsterType>(rand() % MAX_MONSTER_TYPES);
        }
};
class Player: public Creature{
    private:
        int level;
        constexpr static int INITIAL_Health=20;
    public:
        Player() : Creature("Dafault", INITIAL_Health, 0, 1), level{1} {}
        Player(std::string Name) : Creature(Name, INITIAL_Health, 0, 1), level{1} {}
        Player(std::string Name,int Health,int Money,int Attack):Creature(Name,Health,Money,Attack),level{1}{}
        ~Player(){}
        Player operator =(const Player &player){//重载赋值运算符为移动赋值
            *this=std::move(player);
        }
        void Fatch(int goldFetch){//获取金币
            money+=goldFetch;
        }
        void wastedStatus(){
            std::cout << "You died at level " << level << " and with "<<money<< " gold." << std::endl;
            std::cout << "Too bad you can't take it with you!" << std::endl;
        }
        int getLevel(){//获取等级
            return level;
        }
        void LevelUp(){//升级
            ++level;
            ++damage;
            std::cout<<"You are now level "<<level<<"."<<std::endl;
        }
};