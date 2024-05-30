/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2024-05-30 15:40:00
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2024-05-30 16:28:21
 * @FilePath: \GISalgorithm\POJ1065.cpp
 * @Description:
 * @
 * @Copyright (c) 2024 by ChanningTong, All Rights Reserved.
 */
/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2024-05-30 15:40:00
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2024-05-30 16:07:19
 * @FilePath: \undefinedc:\Users\Administrator\GitHub\MyCoding\Cpp\CUG\GISalgorithm\POJ1065.cpp
 * @Description:
 * @
 * @Copyright (c) 2024 by ChanningTong, All Rights Reserved.
 */
#include<iostream>
#include<vector>
#include<algorithm>

class Wood{
    int len,val;
public:
    Wood():len(0),val(0){}
    Wood(int len,int val):len(len),val(val){}
    bool operator<(const Wood& wood){
        if (len == wood.len)  return val < wood.val;
        return len < wood.len;
    }
    int getVal() const {return val;}
};
bool cmps(const int a, const int b) { return a > b; }
int LDS(const std::vector<int>& num){
    std::vector<int> f;
    for (std::vector<int>::const_iterator it = num.begin(); it != num.end(); it++){
        std::vector<int>::iterator pos = std::lower_bound(f.begin(),f.end(),*it,cmps);
        if (pos == f.end()) f.push_back(*it);
        else    *pos = *it;
    }
    return (int)f.size();
}
void solve(){
    int n;
    std::cin>>n;
    std::vector<Wood> woods(n);
    for (int i = 0; i < n; i++){
        int len,val;
        std::cin>>len>>val;
        woods[i] = Wood(len,val);
    }
    std::sort(woods.begin(),woods.end());
    std::vector<int> num(n);
    for (int i = 0; i < n; i++) num[i] = woods[i].getVal();
    std::cout<<LDS(num)<<std::endl;
    return;
}
int main(){
    int t;
    std::cin>>t;
    while (t--) solve();
    return 0;
}