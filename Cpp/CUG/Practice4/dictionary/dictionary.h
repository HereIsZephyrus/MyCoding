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
#include <vector>

constexpr int PARTOFSPEECHNUM=9;
static std::string partName[PARTOFSPEECHNUM]={"n.","v.","adj.","adv.","prep.","conj.","pron.","num.","int."};
class Word{
private:
    std::string word;
    std::string explain;
    //enum partType type;
    //unsigned int type{0};
    std::vector<unsigned short> type;
    int index{0};
    //partType getPartType(std::string s){
    void getPartType(std::vector<unsigned short>& type,std::string s);
    std::string printType(const std::vector<unsigned short> type) const;
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
                    getPartType(type,s.substr(prev,s.length()-prev));
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
    std::vector<unsigned short> getType() const { return type; }
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
    ~Trie(){
        for (int i=0;i<26;++i)
            if (next[i]!=nullptr)
                delete next[i];
    }
    void insert(Word* key);
    int search(std::string key);
};
void Trie::insert(Word* key){
    Trie* node=this;
    const std::string word=key->getWord();
    for (int i=0;i<key->getLen();++i){
        if (word[i]=='-' || word[i]=='/')
            continue;
        if (node->next[word[i]-'a']==nullptr)
            node->next[word[i]-'a']=new Trie();
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

void Word::getPartType(std::vector<unsigned short> & type,std::string s){
    s = s + ',';
    unsigned int prev = 0;
    bool exist = false;
    for (unsigned int pos = 0; pos < s.length(); ++pos){
        if (s[pos] == ','){
            std::string tmp = s.substr(prev, pos - prev);
            for (int i = 0; i < PARTOFSPEECHNUM; ++i)
                if (tmp == partName[i]){
                    exist = true;
                    //type = type | (1 << i); // 用二进制数据存储词性
                    type.push_back(i);
                    //std::cout<<partName[i]<<' ';
                }
            prev = pos + 1;
        }
    }
    //std::cout<<index<<std::endl;
    //system("pause");
    if (!exist){
        std::cout << "Error: unknown part of speech" << std::endl;
        exit(index);
    }
}
std::string Word::printType(const std::vector<unsigned short> type) const{
    std::ostringstream ostr;
    //std::cout<<type<<std::endl;
    for (std::vector<unsigned short>::const_iterator it=type.begin();it!=type.end();++it){
        ostr<<partName[*it]<<' ';
    }
    //ostr.putback();
    return ostr.str();
}