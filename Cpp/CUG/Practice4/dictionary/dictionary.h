/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-04-30 22:58:57
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-04-30 23:00:41
 * @FilePath: \dictionary\dictionary.h
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#pragma once
#include<iostream>
#include<cstring>
#include<string>
#include<cmath>

constexpr short PARTOFSPEECHNUM=10;
static std::string partName[PARTOFSPEECHNUM]={"noun","verb","adj","adv","prep","conj","pron","art","num","interj"};
class Word{
public:
    enum partType{
        noun,
        verb,
        adj,
        adv,
        prep,
        conj,
        pron,
        art,
        num,
        interj,
        MAX_PART=PARTOFSPEECHNUM
    };
private:
    std::string word;
    std::string explain;
    enum partType type;
    int index{0};
    partType getPartType(std::string s){
        for (int i=0;i<PARTOFSPEECHNUM; ++i)
            if (s==partName[i])
                return static_cast<partType>(i);
        std::cerr<<"Error: unknown part of speech"<<std::endl;
        exit(1);
        return MAX_PART;
    }
public:
    Word()=delete;
    explicit Word(std::string s,int ind):index(ind){
        unsigned int prev=0;
        for (unsigned int pos=0; pos<s.length(); ++pos){
            if (s[pos]=='\t'){
                if (prev==0){
                    word=s.substr(prev,pos-prev);
                    prev=pos+1;
                }
                else{
                    explain=s.substr(prev,pos-prev);
                    prev=pos+1;
                    type = getPartType(s.substr(prev + 1));
                }
            }
        }
    }
    ~Word(){}
    void Print(){
        std::cout<<"word:"<<word<<std::endl;
        std::cout<<"explain:"<<explain<<std::endl;
        std::cout<<"part of speech:"<<partName[type]<<std::endl;
    }
    int getIndex() const{
        return index;
    }
    int getLen() const{
        return word.length();
    }
    std::string getWord() const{
        return word;
    }
    friend std::ostream& operator<<(std::ostream& os, const Word& word){
        os<<word.word<<'\t'<<word.explain<<'\t'<<partName[word.type]<<std::endl;
        return os;
    }
};

class Trie{
private:
    Trie*next[26];
    int loc;
public:
    Trie():loc(-1){
        for (int i=0;i<26;++i)
            next[i]=nullptr;
    }
    void insert(Word* key);
    int search(std::string key);
};
void Trie::insert(Word* key){
    Trie* node=this;
    const std::string word=key->getWord();
    for (int i=0;i<key->getLen();++i){
        if (node->next[word[i]-'a']==nullptr){
            node->next[word[i]-'a']=new Trie();
        }
        node=node->next[word[i]-'a'];
    }
    node->loc=key->getIndex();
}
int Trie::search(const std::string key){
    Trie* node=this;
    for (int i=0;i<key.length();++i){
        if (node->next[key[i]-'a']==nullptr)
            return -1;
        node=node->next[key[i]-'a'];
    }
    if (node!=nullptr&&node->loc!=-1)
        return node->loc;
    return -1;
}