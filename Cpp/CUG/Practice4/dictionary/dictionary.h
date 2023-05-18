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
#include<fstream>
#include<sstream>
#include<cstring>
#include<string>
#include<cmath>

constexpr short PARTOFSPEECHNUM=8;
static std::string partName[PARTOFSPEECHNUM]={"n.","v.","adj.","adv.","prep.","conj.","pron.","num."};
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
        num,
        MAX_PART=PARTOFSPEECHNUM
    };
private:
    std::string word;
    std::string explain;
    //enum partType type;
    unsigned short type{0};
    int index{0};
    //partType getPartType(std::string s){
    unsigned short getPartType(std::string s);
    std::string printType(const unsigned short type) const;
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
                    type = getPartType(s.substr(prev,s.length()-prev));
                }
            }
        }
    }
    ~Word(){}
    void Print(){
        std::cout<<"word:"<<word<<std::endl;
        std::cout<<"explain:"<<explain<<std::endl;
        std::cout << "part of speech:" << printType(type)<< std::endl;
    }
    int getIndex() const    {return index;}
    int getLen() const      {return word.length();}
    unsigned short getType() const     {return type;}
    std::string getWord() const{return word;}
    std::string getExplain() const{return explain;}
    friend std::ostream& operator<<(std::ostream& os, const Word& word){
        os<<word.getWord()<<'\t'<<word.getExplain()<<'\t'<<word.printType(word.getType())<<std::endl;
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

unsigned short Word::getPartType(std::string s){
    s = s + ',';
    unsigned int prev = 0;
    bool exist = false;
    for (unsigned int pos = 0; pos < s.length(); ++pos){
        if (s[pos] == ','){
            std::string tmp = s.substr(prev, pos - prev);
            for (int i = 0; i < PARTOFSPEECHNUM; ++i)
                if (tmp == partName[i]){
                    exist = true;
                    type |= (1 << i); // 用二进制数据存储词性
                }
            prev = pos + 1;
        }
    }
    if (!exist){
        std::cerr << "Error: unknown part of speech" << std::endl;
        exit(2);
    }
    return MAX_PART;
}
std::string Word::printType(const unsigned short type) const{
    std::ostringstream ostr;
    for (int ind=0,x=type; x; x>>=1,++ind)
        if (x&1)
            ostr<<partName[ind]<<" ";
    //ostr.putback();
    return ostr.str();
}