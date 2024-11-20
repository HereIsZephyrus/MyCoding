#include<iostream>
#include<cstring>
#include<string>
#include<vector>
#include<cmath>

int main(){
    std::string s1,s2;
    while (std::cin>>s1>>s2){
        size_t len1 = s1.length(),len2 = s2.length();
        std::vector<std::vector<int> > f(len1+1,std::vector<int>(len2+1,0));
        for (int i = 0; i <= len1; i++)    f[i][0] = 0;
        for (int j = 0; j <= len2; j++)    f[0][j] = 0;
        for (int i = 1; i <= len1; i++){
            for (int j = 1; j <= len2; j++){
                if (s1[i-1] == s2[j-1])
                    f[i][j] = f[i-1][j-1] + 1;
                else
                    f[i][j] = std::max(f[i-1][j],f[i][j-1]);
            }
        }
        std::cout<<f[len1][len2]<<std::endl;
    }
    return 0;
}