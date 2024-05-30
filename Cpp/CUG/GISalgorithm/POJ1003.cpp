#include<iostream>
constexpr int MAXN = 300;

int search(float cumsum[], float length){
    int left = 0;
    int right = MAXN;
    while (left<right){
        int mid = left + (right-left)/2;
        if (cumsum[mid]<length)
            left = mid+1;
        else
            right = mid;
    }
    return left;
}
int main(){
    float length;
    float cumsum[MAXN];
    cumsum[0] = 0;
    for (int i=1;i<MAXN;i++)
        cumsum[i] = cumsum[i-1] + 1.0/(i+1);
    std::cin>>length;
    while (length>0){
        std::cout<<search(cumsum,length)<<" card(s)"<<std::endl;
        std::cin>>length;
    }
    return 0;
}