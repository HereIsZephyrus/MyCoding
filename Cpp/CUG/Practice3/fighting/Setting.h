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
#include<cstring>
#include<iostream>
#include<cmath>
constexpr int MAX_MONSTER_TYPES=3;
constexpr int MAX_POTION_TYPES=4;
constexpr int MAX_POTION_SIZES=3;

class Potion;
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
    std::string getName() const{
        return name;
    }
    int getWinCount() const{
        return winCount;
    }
    int getGold() const{
        return gold;
    }
};
class Creature{
    protected://如果变量申明的顺序不同于构造顺序则编译器会抛出一个warning,记一笔
        std::string name;
        int health;
        int money;
        int damage;
    public:
        Creature()=delete;
        Creature(std::string Name,int Health,int Money,int Attack):name{Name},health{Health},money{Money},damage{Attack}{}
        ~Creature(){}
        void display() const{
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
        bool alive() const{
            return health>0;
        }
        int Contain() const{
            return money;
        }
        int getAttack() const{
            return damage;
        }
        int getHealth() const{
            return health;
        }
        std::string getName() const{
            return name;
        }
};
class Monster: public Creature{
    public:
        enum MonsterType{
            DRAGON,
            ORC,
            SLIME,
            MONSTER_TYPES=MAX_MONSTER_TYPES
        };
        static const std::string typeString[];
    private:
        static constexpr int typeHealth[MAX_MONSTER_TYPES]{20,4,1};
        static constexpr int typeMoney[MAX_MONSTER_TYPES]{100,25,10};
        static constexpr int typeAttack[MAX_MONSTER_TYPES]{4,2,1};
        static constexpr char typeSymbol[MAX_MONSTER_TYPES]{'D','O','S'};
    public:
        Monster():Creature("Default",1,0,1){
            MonsterType tmpType = static_cast<MonsterType>(rand() % MAX_MONSTER_TYPES);
            name = typeString[tmpType];
            health = typeHealth[tmpType];
            money = typeMoney[tmpType];
            damage = typeAttack[tmpType];
        }
        //Monster(MonsterType type):Creature(typeString[type],typeHealth[type],typeMoney[type],typeAttack[type]){}
        Monster(std::string Name, int Health, int Money, int Attack) : Creature(Name,Health,Money,Attack) {}
        static MonsterType getRandomMonster(){
            return static_cast<MonsterType>(rand() % MAX_MONSTER_TYPES);
        }
};
class Player: public Creature{
    private:
        int level;
        constexpr static int INITIAL_Health=20;
        bool recognize[MAX_POTION_TYPES]={false};
    public:
        Player() : Creature("Dafault", INITIAL_Health, 0, 1), level{1} {}
        Player(std::string Name) : Creature(Name, INITIAL_Health, 0, 1), level{1} {}
        Player(std::string Name,int Health,int Money,int Attack):Creature(Name,Health,Money,Attack),level{1}{}
        ~Player(){}
        Player operator =(const Player &player){//重载赋值运算符为移动赋值
            *this=std::move(player);
            return *this;
        }
        void Fatch(int goldFetch){//获取金币
            money+=goldFetch;
        }
        void wastedStatus() const{
            std::cout << "You died at level " << level << " and with "<<money<< " gold." << std::endl;
            std::cout << "Too bad you can't take it with you!" << std::endl;
        }
        int getLevel() const{//获取等级
            return level;
        }
        void LevelUp(){//升级
            ++level;
            ++damage;
            std::cout<<"You are now level "<<level<<"."<<std::endl;
        }
        void effectHeal(int value){
            health+=value;
        }
        void effectAttack(int value){
            damage+=value;
        }
        bool is_recognized(int typeind) const{
            return recognize[typeind];
        }
        void RecognizePotion(int typeind){
            recognize[typeind]=true;
        }
};

class Potion{
    public:
        enum PotionType{
            HEALTH,
            STRENGTH,
            POISON,
            WEEKNESS,
            POTION_TYPES=MAX_POTION_TYPES
        };
        enum PotionSize{
            SMALL,
            MEDIUM,
            LARGE,
            POTION_SIZES=MAX_POTION_SIZES
        };
        static const std::string typeString[];
        static const std::string sizeString[];

    private:
        static const std::string forward_typeEffect[];
        static const std::string backward_typeEffect[];
        constexpr static char typeSymbol[MAX_POTION_TYPES]{ 'H', 'S', 'P', 'W' };
        constexpr static int effectMedium[MAX_POTION_TYPES]{ 2, 1, -1,-1 };
        constexpr static int effectLarge[MAX_POTION_TYPES]{ 5, 2, -2,-2 };
        constexpr static double effectProbability=0.7;
        PotionType type;
        PotionSize size;
    public:
        Potion():type{HEALTH},size{MEDIUM}{
            type=getRandomPotion();
            size=getRandomPotionSize();
        }
        static PotionType getRandomPotion(){
            return static_cast<PotionType>(rand() % MAX_POTION_TYPES);
        }
        static PotionSize getRandomPotionSize(){
            return static_cast<PotionSize>(rand() % MAX_POTION_SIZES);
        }
        void Drinked(Player &player){
            switch (size){
            case PotionSize::SMALL:
                std::cout << "You drink a small " << typeString[type] << " potion." << std::endl;
                if (rand() % 100 < effectProbability * 100)
                {
                    std::cout << "It" << forward_typeEffect[type] << abs(effectMedium[type]) << backward_typeEffect[type] << std::endl;
                    Effect(type, size, player);
                }
                else
                    std::cout << "You don't feel it works." << std::endl;
                break;
            case PotionSize::MEDIUM:
                std::cout << "You drink a medium " << typeString[type] << " potion." << std::endl;
                std::cout << "It" << forward_typeEffect[type] << abs(effectMedium[type]) << backward_typeEffect[type] << std::endl;
                Effect(type, size, player);
                break;
            case PotionSize::LARGE:
                std::cout << "You drink a large " << typeString[type] << " potion." << std::endl;
                std::cout << "You drink a medium " << typeString[type] << " potion." << std::endl;
                std::cout << "It" << forward_typeEffect[type] << abs(effectLarge[type]) << backward_typeEffect[type] << std::endl;
                Effect(type, size, player);
                break;
            default:
                break;
            }
        }
        void Effect(PotionType type,PotionSize size,Player &player){
            switch (type){
            case PotionType::HEALTH:
                    switch (size){
                    case PotionSize::SMALL:
                    player.effectHeal(effectMedium[type]);
                    break;
                    case PotionSize::MEDIUM:
                    player.effectHeal(effectMedium[type]);
                    break;
                    case PotionSize::LARGE:
                    player.effectHeal(effectLarge[type]);
                    break;
                    default:
                    break;
                    }
                    break;
            case PotionType::STRENGTH:
                    switch (size){
                    case PotionSize::SMALL:
                    player.effectAttack(effectMedium[type]);
                    break;
                    case PotionSize::MEDIUM:
                    player.effectAttack(effectMedium[type]);
                    break;
                    case PotionSize::LARGE:
                    player.effectAttack(effectLarge[type]);
                    break;
                    default:
                    break;
                    }
                    break;
            case PotionType::POISON:
                    switch (size){
                    case PotionSize::SMALL:
                    player.effectHeal(effectMedium[type]);
                    break;
                    case PotionSize::MEDIUM:
                    player.effectHeal(effectMedium[type]);
                    break;
                    case PotionSize::LARGE:
                    player.effectHeal(effectLarge[type]);
                    break;
                    default:
                    break;
                    }
                    break;
                default:
                    break;
            }
        }
        int indexType() const{
            return type;
        }
        std::string getSize() const{
            return sizeString[type];
        }
        std::string getType() const{
            return typeString[type];
        }
};

const std::string Monster::typeString[MAX_MONSTER_TYPES]{"dragon", "orc", "slime"};
const std::string Potion::typeString[MAX_POTION_TYPES]{"health", "strength", "poison", "weakness"};
const std::string Potion::sizeString[MAX_POTION_SIZES]{"small", "medium", "large"};
const std::string Potion::forward_typeEffect[MAX_POTION_TYPES]{" heal ", " increase your attack by ", " poison you for ", " decrease your attack by "};
const std::string Potion::backward_typeEffect[MAX_POTION_TYPES]{" health.", " points.", " points.", " points."};