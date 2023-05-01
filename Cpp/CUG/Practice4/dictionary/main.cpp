/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-04-30 22:31:28
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-04-30 23:21:05
 * @FilePath: \dictionary\main.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#include "dictionary.h"
#include<vector>
#include<fstream>
int main(){
    std::vector<Word> dict;
    Trie* head=new Trie();
    static unsigned int numWords=0;
    std::ifstream fin("dictionary.txt");
//    std::ofstream fout("dictionary.out");
    while (!fin.eof()){//read dictionary
        std::string s;
        std::getline(fin, s);
        Word word(s, numWords++);
        dict.push_back(word);
        head->insert(&word);
//        fout<<word;
    }
    fin.close();
//    fout.close();
    std::cin.get();//clear the buffer
    system("pause");
    std::cout<<"Welcome to the dictionary!\nPlease input the word that you want to quary(enterQUITto quit)"<<std::endl;
    std::string quary;
    std::cin>>quary;
    while (quary!="QUIT"){
        int index=head->search(quary);
        if (index==-1) std::cout<<"Sorry, the word you quary is not in the dictionary."<<std::endl;
        else
            dict[index].Print();
    }
    std::cin.get();//pause
    return 0;
}