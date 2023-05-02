#include <algorithm> // std::shuffle
#include <cassert>
#include <ctime> // std::time
#include <iostream>
#include <random> // std::mt19937
#include <vector>
#include "blackjack.h"


std::vector<Player> players;

int main(){
    static int playerNum{ 1 };
    std::cout<<"How many players? ";
    std::cin>>playerNum;
    getTable(playerNum);

    auto deck{ createDeck() };//初始化牌堆
    shuffleDeck(deck);//洗牌

    static int Counting{ 0 };
    while (!finished()){
        std::cout << "Round " << ++Counting << ":\n";
        playOneRound(deck);
    }
    std::cin.get();
    std::cin.get();
    return 0;
}

inline void printCard(const Card& card){
    static const char cardNames[MAXRANKS]{ '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'};
    static const char suitNames[MAXSUITS]{ 'C', 'D', 'H', 'S'};
    std::cout << cardNames[static_cast<int>(card.rank)] << suitNames[static_cast<int>(card.suit)];
}

inline int getCardValue(const Card& card){
    return static_cast<int>(card.rank)+2;
}
Card getCard(Index &index, Deck &deck){
    Card fetch=deck[index];
    index++;
    if (static_cast<int>(index)>52){
        index = static_cast<Index>(0);
        shuffleDeck(deck);
    }
    return fetch;
}

void printDeck(const Deck& deck){
    for (const auto& card : deck){
        printCard(card);
        std::cout << ' ';
    }
    std::cout << '\n';
}

Deck createDeck(){//初始化牌堆
    Deck deck{};
    Index index{ 0 };
    for (int suit{ 0 }; suit < static_cast<int>(CardSuit::max_suits); ++suit){
        for (int rank{ 0 }; rank < static_cast<int>(CardRank::max_ranks); ++rank){
            deck[index].suit = static_cast<CardSuit>(suit);
            deck[index].rank = static_cast<CardRank>(rank);
            ++index;
        }
    }
    return deck;
}

void shuffleDeck(Deck& deck){ // 洗牌
    static std::mt19937 mt{ static_cast<std::mt19937::result_type>(std::time(nullptr)) };
    std::shuffle(deck.begin(), deck.end(), mt);
}

bool playerWantsHit(){//玩家是否要牌的决策函数
    while (true){
        std::cout << "(h) to hit, or (s) to stand: ";
        char ch{};
        std::cin>>ch;
        while (true){
            switch (ch){
            case 'h':
                return true;
            case 's':
                return false;
            default:
                std::cout << "Sorry, I don't understand that.\n";
            }
            std::cin>>ch;
        }
    }
}

// Returns true if the player went bust. False otherwise.
bool playerTurn(Deck& deck, Index& nextCardIndex, Player& player){
    while (true){
        if (player.score > g_maximumScore){
            // This can happen even before the player had a choice if they drew 2
            // aces.
            std::cout << "You busted!\n";
            return true;
        }
        else{
            if (playerWantsHit()){ // 玩家要牌
                int cardValue{ getCardValue(getCard(nextCardIndex,deck)) };//从牌堆中抽出一张
                player.score += cardValue;
                std::cout << "You were dealt a " << cardValue << " and now have " << player.score << '\n';
            }
            else// 玩家没爆
                return false;
        }
    }
}
// Returns true if the dealer went bust. False otherwise.
bool dealerTurn(Deck& deck, Index& nextCardIndex, Player& dealer){
    // Draw cards until we reach the minimum value.
    while (dealer.score < g_minimumDealerScore){
        int cardValue{ getCardValue(getCard(nextCardIndex,deck)) };//从牌堆中抽出一张
        dealer.score += cardValue;
        std::cout << "The dealer turned up a " << cardValue << " and now has " << dealer.score << '\n';
    }
    // If the dealer's score is too high, they went bust.
    if (dealer.score > g_maximumScore){
        std::cout << "The dealer busted!\n";
        return true;
    }
    return false;//庄家没爆
}

void getTable(int playerNum){
    Player dealer{500, "ChanningTong"};
    dealer.printInfo();
    players.push_back(dealer);
    for(int i=0;i<playerNum;++i){
        std::string name;
        int money;
        std::cout<<"Player"<<i+1<<":"<<std::endl;
        std::cin>>name;
        std::cout<<"Sit down,"<<name<<"!You have $"<<initMoney<<std::endl;
        Player player{initMoney, name};
        players.push_back(player);
    }
}

void playOneRound(Deck& deck){
    for(auto& player: players)
        player.score = 0;
    for (auto& player : players){
        if (player.name != "ChanningTong"){
            std::cout << player.name << ", you have $" << player.getMoney() << ".\n";
            std::cout << "How much do you want to bet? ";
            int bet{ 0 };
            std::cin >> bet;
            while (bet > player.getMoney()){
                std::cout << "You can't bet more than you have.\n";
                std::cout << "How much do you want to bet? ";
                std::cin >> bet;
            }
            //player.change(-bet);
            player.bet = bet;
            std::cout << '\n';
        }
    }
    // Create the dealer and give them 1 card.
    Player* dealer=&players[0];
    dealer->score = getCardValue(getCard(nextCardIndex,deck));
    std::cout << "The dealer is showing: " << dealer->score << '\n';
    // Play the player's turn.
    for (std::vector<Player>::iterator iter=players.begin()+1;iter!=players.end();++iter){
        Player player=*iter;
        std::cout << '\n';
        std::cout << player.name << "'s turn:\n";
        player.score = getCardValue(getCard(nextCardIndex,deck)) + getCardValue(getCard(nextCardIndex,deck));
        std::cout << "You have: " << player.score << '\n';
        if (playerTurn(deck, nextCardIndex, player)){
            player.change(-player.bet);
            player.score = -1;
            std::cout << player.name << ", you lost! You have $" << player.getMoney() << " left.\n";
            if (player.isBroke()){
                std::cout << player.name << ", you have no money left. You are out of the game!\n";
                players.erase(iter);
            }
        }
        else
            std::cout << player.name << ", you have " << player.score <<" in this round. Let's see."<< '\n';
    }
    if (!dealerTurn(deck, nextCardIndex, *dealer)){
        for (auto& player : players){
            if (player.name != "ChanningTong" && player.score != -1){
                player.change(player.bet);
                dealer->change(-player.bet);
                std::cout << player.name << ", you won! You have $" << player.getMoney() << " now.\n";
            }
        }
    }
    else{
        for (std::vector<Player>::iterator iter = players.begin() + 1; iter != players.end(); ++iter){
            Player player=*iter;
            if (player.score > dealer->score){
                player.change(player.bet);
                dealer->change(-player.bet);
                std::cout << player.name << ", you won! You have $" << player.getMoney() << " now.\n";
            }
            else if (player.score < dealer->score){
                player.change(-player.bet);
                dealer->change(player.bet);
                std::cout << player.name << ", you lost! You have $" << player.getMoney() << " left.\n";
                if (player.isBroke()){
                    std::cout << player.name << ", you have no money left. You are out of the game!\n";
                    players.erase(iter);
                }
            }
            else
                std::cout << player.name << ", you draw! You have $" << player.getMoney() << " now.\n";
        }
    }
}

bool finished(){
    if (players.size() == 1){
        std::cout<<"All players were out!The dealer win!"<<std::endl;
        players[0].printInfo();
        return true;
    }
    if (players[0].isBroke()){
        std::cout<<"The dealer was bankrupt!"<<std::endl;
        for(int i=1;i<players.size();++i)
            players[i].printInfo();
        return true;
    }
    return false;
}
