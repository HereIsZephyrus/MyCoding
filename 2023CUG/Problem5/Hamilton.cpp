#include<iostream>
#include<fstream>
#include<cmath>
using std::cin;
using std::cout;
constexpr MAXN=1000;
constexpr MAXM=1000;
struct Edge
{
    int v;
    int next;

}edge[MAXM];

int n, m, edgeNum{0},pathNum{0};
int head[MAXN],path[MAXN],hash[MAXM];
bool vis[MAXN];

void DFS(int u,int t)
{
    if (t==n)
        return;
    for (int e=head[u]; e!=-1; e=edge[e].next)
    {
        int v=edge[e].v;
        if (!vis[v])
        {
            vis[v] = true;
            path[k+1] = v;
            DFS(v, k+1);
            vis[v] = false;
        }
    }
    return;
}
void AddEdge(int u, int v){
   // 添加边
    edgeNum++;
    edge[edgeNum].v = v;
    edge[edgeNum].next = head[u];
    head[u] = edgeNum;
    // 添加反向边
    edgeNum++;
    edge[edgeNum].v = u;
    edge[edgeNum].next = head[v];
    head[v] = edgeNum;
}
void Print()
{
    for (int i=1; i<=n; ++i)
        cout << path[i] << " ";
    cout <<endl;
    return;
}

void InitGraph()
{   
    //初始化
    cin >> n >> m >>pathNum;
    for (int i=1; i<=n; ++i)
        head[i] = -1;
    // 输入链向星的图
    for (int e=1; e<=m; ++e){
        int u, v;
        cin >> u >> v;
        AddEdge(u, v);
    }
    return;
}
void Solve(int root)
{
    // 从root开始搜索哈密顿路径
    path[1] = root;
    int k=1;
    while (k<=pathNum;)
    {
        for (int i=1; i<=n; ++i)
            vis[i] = false;
        for (int i=1; i<=n; ++i)
            path[i] = 0;
        vis[root] = true;
        DFS(root, 1);
        int tmpHash=CalcHash();
        bool exist=false;
        for (int i=1; i<k; ++i)
        {
            if (hash[i] == tmpHash)
            {
                exist=true;
                break;
            }
        }
        if (!exist)
        {
            hash[k] = tmpHash;
            if (tmpHash>0)
                Print();
            k++;
        }
    }
    return;
}

int main()
{
    freopen("Path.txt", "r", stdin);
    freopen("Hamilton.txt", "w", stdout);
    InitGraph();   
    Solve(5);
    return 0;
}