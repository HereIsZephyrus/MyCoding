#include<iostream>
#include<vector>
#include<algorithm>

class Wood{
    int len,val;
public:
    Wood(int len,int val):len(len),val(val){}
    bool operator<(const Wood& wood){
        if (len == wood.len)  return val < wood.val;
        return len < wood.len;
    }
    int getVal() const {return val;}
};
int LDS(const std::vector<int>& num){
    std::vector<int> f;
    for (std::vector<int>::const_iterator it = num.begin(); it != num.end(); it++){
        std::vector<int>::iterator pos = std::lower_bound(f.begin(),f.end(),*it);
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
}
int main(){
    int t;
    std::cin>>t;
    while (t--) solve();
    return 0;
}