/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2024-05-30 15:40:00
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2024-05-30 21:11:17
 * @FilePath: \GISalgorithm\POJ3714.cpp
 * @Description:
 * @
 * @Copyright (c) 2024 by ChanningTong, All Rights Reserved.
 */
/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2024-05-30 15:40:00
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2024-05-30 20:51:35
 * @FilePath: \GISalgorithm\POJ3714.cpp
 * @Description:
 * @
 * @Copyright (c) 2024 by ChanningTong, All Rights Reserved.
 */
#include <iostream>
#include <algorithm>
#include <vector>
#include <cmath>
#include <iomanip>
using std::cin;
using std::cout;
using std::endl;
const double INF = 9e10;
class Point {
    bool isAgent;
public:
    double x, y;
    Point(): x(0), y(0), isAgent(false) {}
    Point(double x, double y, bool isAgent) : x(x), y(y), isAgent(isAgent) {}
    bool operator < (const Point &p) const {
        return x < p.x || (x == p.x && y < p.y);
    }
    bool const getIsAgent() { return isAgent; }
};
bool cmpy(const Point &a, const Point &b) { return a.y < b.y; }
double dist(Point a,Point b) {
    if (a.getIsAgent() == b.getIsAgent()) return INF;
    const double x = (a.x - b.x) * (a.x - b.x);
    const double y = (a.y - b.y) * (a.y - b.y);
    return sqrt(x + y);
}
double distX(Point a,Point b){
    return abs(a.x - b.x);
}
double merge(int left, int right, const std::vector<Point> &S) {
    double d = INF;
    if(left == right) return d;
    int mid = left + (right - left) / 2;
    double d1 = merge(left, mid, S);
    double d2 = merge(mid + 1, right, S);
    d = std::min(d1, d2);
    std::vector<Point> temp;
    for (int i = left; i < right; i++)
        if (distX(S[i], S[mid]) < d)
            temp.push_back(S[i]);
    for (std::vector<Point>::iterator i = temp.begin(); i != temp.end(); i++)
        for (std::vector<Point>::iterator j = i+1; j != temp.end(); j++){
            if ((j->y) - (i->y) > d) break;
            d = std::min(d, dist(*i, *j));
        }
    return d;
}
double solve(){
    int n;
    cin >> n;
    std::vector<Point> S(2*n);
    for(int i = 0; i < n; i++) {
        int x,y;
        cin>>x>>y;
        S[i] = Point(x, y, false);
        //S.push_back(Point(x, y, false));
    }
    for(int i = 0; i < n; i++) {
        int x,y;
        cin>>x>>y;
        S[n+i] = Point(x, y, true);
        //S.push_back(Point(x, y, true));
    }
    std::sort(S.begin(), S.end());
    //for (std::vector<Point>::iterator i = S.begin(); i != S.end(); i++)
    //    cout<<i->x<<' '<<i->y<<' '<<i->getIsAgent()<<endl;
    return merge(0, 2*n - 1, S);
}
int main() {
    int t;
    std::cin>>t;
    while (t--)
        cout<<std::setiosflags(std::ios::fixed)<<std::setprecision(3)<<solve()<<endl;
    getchar();getchar();
    return 0;
}