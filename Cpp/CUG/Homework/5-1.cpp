/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-04-05 15:36:18
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-04-05 15:38:13
 * @FilePath: \Homework\5-1.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
// 关于对字符串常量初始化的问题
// https://stackoverflow.com/questions/48759558/a-value-of-type-const-char-cannot-be-used-to-initialize-an-entity-of-type-ch
#include<iostream>
#include<assert.h>

class MyString{
public:
    explicit MyString(char* str): m_pstr(str) {};    //构造函数
    MyString(): m_pstr(){};      //构造函数
    ~MyString() {delete m_pstr;};    //析构函数
    MyString operator=(MyString str){
        delete m_pstr;
        m_pstr = str.m_pstr;
        return *this;
    }
    int* c_str() const{ // 返回字符串首地址
        return (int*)m_pstr;
    }
    unsigned int size() const{
        const char *p = this->m_pstr;
        unsigned int len = 0;
        for ( ;p[len] != '\0'; ++len);//end
        return len;
    }
    // 比较大小
    bool operator< (const MyString str) const;
    bool operator== (const MyString str) const;
    bool operator> (const MyString str) const;
    bool operator<= (const MyString str) const;
    bool operator>= (const MyString str) const;
    bool operator!= (const MyString str) const;
    //合并字符串
    MyString operator+(const MyString &str) const;
    MyString &operator+=(const MyString &str);
    //TCB:这是一个没有任何意义的重载，所以不打算重载
    /*返回某个字符，从0开始
    char operator[](int index) const{
        const char *p = &m_pstr;
        return *(p[index]);
    /}
    char& operator[](int index){
        char *p = &(char*)m_pstr;
        return *(p[index]);
    }*/
   friend std::ostream& operator << (std::ostream& os, const MyString& str);    //输出字符串
private:
    char*  m_pstr=nullptr;
};

int main(){
    char    sBuffer[256];
    MyString s1;
    MyString s2;
    std::cin.getline(sBuffer, 256);
    s1=MyString(sBuffer);
    std::cin.getline(sBuffer, 256);
    s2=MyString(sBuffer);
    char op[3];
    std::cin.getline(op, 3);
    while(op[0] != 'X'){
        switch(op[0]){
            case '+': {
                if (op[1]=='='){
                    s1+=s2;
                    std::cout << s1 << std::endl;
                }
                else
                    std::cout << (s1+s2) << std::endl;
                break;
            }
            case '<':{
                if (op[1]=='=')
                    std::cout << (s1<=s2) << std::endl;
                else
                    std::cout << (s1<s2) << std::endl;
                break;
            }
            case '>':{
                if (op[1]=='=')
                    std::cout << (s1>=s2) << std::endl;
                else
                    std::cout << (s1>s2) << std::endl;
                break;
            }
            case '=':   std::cout << (s1==s2) << std::endl; break;
            defualt: assert("Error"); break;
        }
        std::cin.getline(sBuffer, 256);
        s1 = MyString(sBuffer);
        std::cin.getline(sBuffer, 256);
        s2 = MyString(sBuffer);
        std::cin.getline(op, 3);
    }
    return 0;
}

bool MyString::operator<(const MyString str) const{
    const char *p1 = m_pstr;
    const char *p2 = str.m_pstr;
    int ind1=0,ind2=0;
    for ( ; p1[ind1] != '\0' && p2[ind2] != '\0'; ++ind1, ++ind2){
        if (p1[ind1] < p2[ind2])
            return true;
        else if (p1[ind1] > p2[ind2])
            return false;
    }
    if (p1[ind1] == '\0' && p2[ind2] != '\0')
        return true;
    else
        return false;
}
bool MyString::operator>(const MyString str) const{
    const char *p1 = m_pstr;
    const char *p2 = str.m_pstr;
    int ind1 = 0, ind2 = 0;
    for ( ; p1[ind1] != '\0' && p2[ind2] != '\0'; ++ind1, ++ind2){
        if (p1[ind1] > p2[ind2])
            return true;
        else if (p1[ind1] < p2[ind2])
            return false;
    }
    if (p1[ind1] != '\0' && p2[ind2] == '\0')
        return true;
    else
        return false;
}
bool MyString::operator==(const MyString str) const{
    const char *p1 = m_pstr;
    const char *p2 = str.m_pstr;
    int ind1 = 0, ind2 = 0;
    for ( ; p1[ind1] != '\0' && p2[ind2] != '\0'; ++ind1, ++ind2){
        if (p1[ind1] != p2[ind2])
            return false;
    }
    if (p1[ind1] == '\0' && p2[ind2] == '\0')
        return true;
    else
        return false;
}
bool MyString::operator!=(const MyString str) const{
    const char *p1 = m_pstr;
    const char *p2 = str.m_pstr;
    int ind1 = 0, ind2 = 0;
    for ( ; p1[ind1] != '\0' && p2[ind2] != '\0'; ++ind1, ++ind2){
        if (p1[ind1] != p2[ind2])
            return true;
    }
    if (p1[ind1] == '\0' && p2[ind2] == '\0')
        return false;
    else
        return true;
}
bool MyString::operator<=(const MyString str) const{
    const char *p1 = m_pstr;
    const char *p2 = str.m_pstr;
    int ind1 = 0, ind2 = 0;
    for ( ; p1[ind1] != '\0' && p2[ind2] != '\0'; ++ind1, ++ind2){
        if (p1[ind1] < p2[ind2])
            return true;
        else if (p1[ind1] > p2[ind2])
            return false;
    }
    if (p1[ind1] == '\0' && p2[ind2] != '\0')
        return true;
    else
        return false;
}
bool MyString::operator>=(const MyString str) const{
    const char *p1 = m_pstr;
    const char *p2 = str.m_pstr;
    int ind1 = 0, ind2 = 0;
    for ( ; p1[ind1] != '\0' && p2[ind2] != '\0'; ++ind1, ++ind2){
        if (p1[ind1] > p2[ind2])
            return true;
        else if (p1[ind1] < p2[ind2])
            return false;
    }
    if (p1[ind1] != '\0' && p2[ind2] == '\0')
        return true;
    else
        return false;
}
// 合并字符串
MyString MyString::operator+(const MyString &str) const{
    MyString res;
    int len1 = size();
    int len2 = str.size();
    std::cout<<m_pstr<<str.m_pstr<<std::endl;
    system("pause");
    res.m_pstr = new char[len1 + len2 + 1];
    for (int i = 0; i < len1; ++i)
        res.m_pstr[i] = m_pstr[i];
    for (int i = 0; i < len2; ++i)
        res.m_pstr[i + len1] = str.m_pstr[i];
    res.m_pstr[len1 + len2] = '\0';
    return res;
}
MyString& MyString::operator+=(const MyString &str){
    int len1 = size();
    int len2 = str.size();
    char *p = new char[len1 + len2 + 1];
    for (int i = 0; i < len1; ++i)
        p[i] = m_pstr[i];
    for (int i = 0; i < len2; ++i)
        p[i + len1] = str.m_pstr[i];
    p[len1 + len2] = '\0';
    delete[] m_pstr;
    m_pstr = p;
    return *this;
}
std::ostream & operator<<(std::ostream &os, const MyString &str){
    os << str.m_pstr;
    return os;
}