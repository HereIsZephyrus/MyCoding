#pragma once
#include<iostream>
#include <cstring>
#include <array>

constexpr unsigned int MAXRANKS=13;
constexpr unsigned int MAXSUITS=4;
constexpr int initMoney=100;
// Maximum score before losing.
constexpr int g_maximumScore{21};
// Minimum score that the dealer has to have.
constexpr int g_minimumDealerScore{17};
enum class CardSuit{
    club,
    diamond,
    heart,
    spade,
    max_suits=MAXSUITS
};

enum class CardRank{
    rank_2,
    rank_3,
    rank_4,
    rank_5,
    rank_6,
    rank_7,
    rank_8,
    rank_9,
    rank_10,
    rank_jack,
    rank_queen,
    rank_king,
    rank_ace,
    max_ranks=MAXRANKS
};

struct Card{
    CardRank rank{};
    CardSuit suit{};
};

using Deck = std::array<Card, 52>; // 牌堆
using Index = Deck::size_type;
static Index nextCardIndex{0};

class Player{
private:
    int money{0};
public:
    int score{0},bet{0};
    std::string name{};
    Player() = default;
    Player(int money, std::string name) : money{money}, score{score}, bet{0},name{name} {}
    //int getScore() const{return score;}
    int getMoney() const{return money;}
    void printInfo(){
        std::cout<<"Name:"<<name<<std::endl;
        std::cout<<"Money:$"<<money<<std::endl;
    }
    bool isBroke(){
        if(money<=0)
            return true;
        else
            return false;
    }
    void change(int Money){
        money+=Money;
    //    std::cout<<"Money:$"<<money<<std::endl;
    }
};
inline void printCard(const Card &card);
inline int getCardValue(const Card &card);
Card getCard(int *index, Deck &deck);
void printDeck(const Deck &deck);
Deck createDeck();
void shuffleDeck(Deck &deck);
bool playerWantsHit();
bool playerTurn(const Deck &deck, Index &nextCardIndex, Player &player);
bool dealerTurn(const Deck &deck, Index &nextCardIndex, Player &dealer);
bool playBlackjack(const Deck &deck);
void getTable(int playerNum);
void playOneRound(Deck &deck);
bool finished();