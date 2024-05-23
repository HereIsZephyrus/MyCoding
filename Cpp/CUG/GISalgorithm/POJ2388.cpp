#include<iostream>
#include<vector>
#include<map>
#include<algorithm>

std::vector<int> calculateRank(const std::vector<int>& arr,int& rank) {
    std::vector<int> sortedArr = arr;
    std::sort(sortedArr.begin(), sortedArr.end());

    std::map<int, int> rankMap;

    for (const int& num : sortedArr)
        if (rankMap.find(num) == rankMap.end()) 
            rankMap[num] = rank++;

    std::vector<int> ranks;
    ranks.reserve(arr.size());

    for (const int& num : arr)
        ranks.push_back(rankMap[num]);

    return ranks;
}

int main(){
    int n;
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