#include<iostream>
int main(){
    int n;
    std::cin>>n;
    while(n != -1){
        int total = 0,standHour;
        while (n--){
            int speed,cumHour;
            std::cin>>speed>>cumHour;
            total = speed * (cumHour - standHour);
            standHour = cumHour;
        }
        std::cout<<total<<" miles"<<std::endl;
        std::cin>>n;
    }
    return 0;
}