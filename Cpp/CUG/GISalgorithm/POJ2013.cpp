#include<iostream>
#include<cstring>
#include<string>
#include<vector>
int main(){
    int n,count = 0;
    std::cin>>n;
    while(n){
        std::vector<std::string> names(n);
        for (int i = 0; i < n; i++)
            std::cin>>names[i];
        std::cout<<"SET "<<++count;
        for (int i = 0; i < n; i+=2)
            std::cout<<names[i]<<std::endl;
        for (int i = 1; i < n; i+=2)
            std::cout<<names[i]<<std::endl;
        std::cin>>n;
    }
    return 0;
}