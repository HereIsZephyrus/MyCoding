#include<iostream>
#include<fstream>
#include<cmath>
#include<cstdlib>
#include<ctime>
using std::ifstream;
using std::ofstream;
using std::cout;
constexpr int MAXN=20;
constexpr int MAXM=300000;
constexpr int MOD=1000000007;
struct Edge
{
    int v{0};
    int next{0};
}edge[MAXM];

int n, m, edgeNum{0},PathTry{MAXM};
int head[MAXN], Path[MAXN],degree[MAXN];
long long hamitonHash[MAXM];
bool vis[MAXN];
ifstream fin("Path.txt");
//ofstream cout("Hamilton.csv",std ::ios::app);

void DFS(int u,int t,int PathLen)
{
    vis[u] = t;
    Path[t] = u;
    if (t >= PathLen)
    {
        return;
    }
    int indV=rand()%degree[u];
    int e=head[u];
    for (int i=0; i<indV; ++i)
        e = edge[e].next;
    int v = edge[e].v;
    for (int count=0; count<100; ++count)
    {
        if (!vis[v])
            break;
        indV=rand()%degree[u];
        e=head[u];
        for (int i=0; i<indV; ++i)
            e = edge[e].next;
        v = edge[e].v;
    }
    if (!vis[v])
    {
        vis[v] = t;
        DFS(v, t + 1,PathLen);
        vis[v] = 0;
    }
    return;
}
void AddEdge(int u, int v){
   //Add edge
    edgeNum++;
    edge[edgeNum].v = v;
    edge[edgeNum].next = head[u];
    head[u] = edgeNum;
    degree[u]++;
    return;
}

void Print(int PathLen)
{
    for (int i=1; i<=PathLen; ++i)
        cout << Path[i] << ",";
    cout << 5 << std::endl;
    return;
}
long long CalcHash(int PathLen)
{
    long long res = 0;
    int len=0;
    for (int i=1; Path[i]; ++i){
        res =res*MAXN%MOD + Path[i];
        ++len;
    }
    if (len != PathLen)
        return -1;
    int u=Path[len];
    for (int e=head[u]; e!=-1; e=edge[e].next)
    {
        int v=edge[e].v;
        if (v == Path[1])
            return res;
    }
    return -1;
}

void InitGraph()
{
    //init
    fin >> n >> m;
    for (int i=0; i<MAXN; ++i)
        head[i] = -1;
    //input graph by stars
    for (int e=1; e<=m; ++e){
        int u, v;
        fin >> u >> v;
        AddEdge(u, v);
        AddEdge(v, u);
    }
    fin.close();
    return;
}
void Solve(int root)
{
    //serach Hamilton Path from the root
    for (int PathLen=n; PathLen>3; --PathLen)
    {
        int cnt=0;
        for (int i=0; i<PathTry; ++i)
            hamitonHash[i] = 0;
        for (int k=0; k<PathTry; ++k)
        {
            for (int i=0; i<MAXN; ++i)
                vis[i] = 0;
            for (int i=0; i<MAXN; ++i)
                Path[i] = 0;
            DFS(root,1,PathLen);
            long long tmpHash=CalcHash(PathLen);
            if (tmpHash<0)
                continue;
            bool exist=false;
            for (int i=1; i<k; ++i)
            {
                if (hamitonHash[i] == tmpHash)
                {
                    exist=true;
                    break;
                }
            }
            if (!exist)
            {
                hamitonHash[++cnt] = tmpHash;
                if (tmpHash > 0)
                {
                    Print(PathLen);
                    cout.flush(); // 将数据刷新到文件中
                }
            }
        }
    }
    return;
}

int main()
{
    freopen("Hamilton-59.csv", "w", stdout);
    std::ios_base::sync_with_stdio(false);
    srand(time(NULL));
    InitGraph();
    Solve(5);
    return 0;
}