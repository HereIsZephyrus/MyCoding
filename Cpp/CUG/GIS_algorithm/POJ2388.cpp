#include<iostream>
#include<vector>
#include<map>
#include<algorithm>

std::vector<int> calculateRank(const std::vector<int>& arr,int& rank) {
    std::vector<int> sortedArr = arr;
    std::sort(sortedArr.begin(), sortedArr.end());
    std::map<int, int> rankMap;
    for (std::vector<int>::const_iterator it = sortedArr.begin(); it != sortedArr.end(); it++)
        if (rankMap.find(*it) == rankMap.end())
            rankMap[*it] = rank++;
    std::vector<int> ranks;
    ranks.reserve(arr.size());
    for (std::vector<int>::const_iterator it = arr.begin(); it != arr.end(); it++)
        ranks.push_back(rankMap[*it]);
    return ranks;
}

int main(){
    int n;
    std::cin>>n;
    std::vector<int> value(n);
    while (n--) {
        int x;
        std::cin >> x;
        value.push_back(x);
    }
    int rank = 1;
    std::vector<int> ranked = calculateRank(value,rank);
    for (int index= 0; index < ranked.size(); index++) {
        if (ranked[index] == (rank + 1) / 2) {
            std::cout << value[index] << std::endl;
            break;
        }
    }
    return 0;
}