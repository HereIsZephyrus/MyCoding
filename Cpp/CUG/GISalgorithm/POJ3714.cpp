#include <iostream>
#include <algorithm>
#include <vector>
#include <cmath>
#include <iomanip>
using std::cin;
using std::cout;
using std::endl;
const int INF = 2 << 20;
class Point {
    bool isAgent;
public:
    double x, y;
    Point() : x(0), y(0), isAgent(false){}
    Point(double x = 0, double y = 0, bool isAgent = false) : x(x), y(y), isAgent(isAgent) {}
    bool operator < (const Point &p) const {
        return x < p.x || (x == p.x && y < p.y);
    }
    bool const getIsAgent() { return isAgent; }

};
bool cmps(const Point &a, const Point &b) { return a.y < b.y; }
double dist(Point a,Point b) {
    if (a.getIsAgent() == b.getIsAgent()) return INF;
    const double x = (a.x - b.x) * (a.x - b.x);
    const double y = (a.y - b.y) * (a.y - b.y);
    return sqrt(x + y);
}
double distX(Point a,Point b){
    if (a.getIsAgent() == b.getIsAgent()) return INF; 
    return abs(a.x - b.x);
}
double merge(int left, int right, const std::vector<Point> &S) {
    double d = INF;
    if(left == right) return d;
    if(left + 1 == right) return dist(S[left], S[right]);
    int mid = left + (right - left) / 2;
    double d1 = merge(left, mid, S);
    double d2 = merge(mid + 1, right, S);
    d = std::min(d1, d2);
    std::vector<Point> temp;
    for(int i = left; i <= right; i++)
        if(distX(S[i], S[mid]) < d)
            temp.push_back(S[i]);
    std::sort(temp.begin(), temp.end(), cmps);
    for (std::vector<Point>::iterator i = temp.begin(); i != temp.end(); i++)
        for (std::vector<Point>::iterator j = i + 1; j != temp.end(); j++)
            d = std::max(d,dist(*i,*j));
    return d;
}
double solve(int n){
    std::vector<Point> S(n * 2);
    for(int i = 0; i < n; i++) {
        int x,y;
        cin>>x>>y;
        S.push_back(Point(x, y, false));
    }
    for(int i = 0; i < n; i++) {
        int x,y;
        cin>>x>>y;
        S.push_back(Point(x, y, true));
    }
    std::sort(S.begin(), S.end());
    return merge(0, 2*n - 1, S);
}
int main() {
    int t;
    while (t--){
        int n;
        cin>>n;
        cout<<std::setprecision(4)<<solve(n)<<endl;
    }
    return 0;
}