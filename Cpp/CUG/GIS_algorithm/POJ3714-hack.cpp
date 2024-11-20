#include <iostream>
#include <cmath>
#include <algorithm>
const int maxn = 2e5 + 5;
const double inf = 1e50;
struct Point{
    double x, y;
    int flag;
    bool operator<(const Point &a) const{return x < a.x;}
} p[maxn], q[maxn];
double Dist(const Point &p1, const Point &p2)
{
    return sqrt((p1.x - p2.x) * (p1.x - p2.x) + (p1.y - p2.y) * (p1.y - p2.y));
}
bool cmpy(Point a, Point b){return a.y < b.y;}
double merge(int l, int r){
    if (l == r)
        return inf;
    int cnt = 0;
    int mid = (l + r) >> 1;
    double ans = std::min(merge(l, mid), merge(mid + 1, r));
    for (int i = l; i <= r; i++)
        if (fabs(p[i].x - p[mid].x) <= ans)
            q[cnt++] = p[i];
    std::sort(q, q + cnt, cmpy);
    for (int i = 0; i < cnt; i++){
        for (int j = i + 1; j < cnt; j++){
            if (q[i].flag == q[j].flag)    continue;
            if (q[j].y - q[i].y > ans)    break;
            ans = std::min(ans, Dist(q[i], q[j]));
        }
    }
    return ans;
}
bool cmp(Point a, Point b)
{
    return a.x < b.x;
}
int main()
{
    int T, n;
    scanf("%d", &T);
    while (T--){
        scanf("%d", &n);
        for (int i = 0; i < 2 * n; i++){
            scanf("%lf%lf", &p[i].x, &p[i].y);
            if (i < n)
                p[i].flag = 0;
            else
                p[i].flag = 1;
        }
        std::sort(p, p + 2 * n);
        printf("%.3f\n", merge(0, 2 * n - 1));
    }
    return 0;
}