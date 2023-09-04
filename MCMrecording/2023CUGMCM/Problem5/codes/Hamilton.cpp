#include<iostream>
#include<fstream>
#include<cmath>
#include<cstdlib>
#include<ctime>
using std::ifstream;
using std::ofstream;
using std::cout;
constexpr int MAXN=20;
constexpr int MAXM=100000;
constexpr int MOD=1000000007;
struct edge
{
    int v{0},u{0};
    int next{0};
}Edge[MAXM],resEdge[MAXM];

int n, m, edgeNum{0}, edgeResNum{0},PathTry{MAXM};
int Head[MAXN], Path[MAXN], Degree[MAXN], nodeNum { 0 },node[MAXN];
int resHead[MAXN], resPath[MAXN], resDegree[MAXN];
long long hamitonHash[MAXM];
bool vis[MAXN];
ifstream fin("Path.txt");
//ofstream cout("Hamilton.csv",std ::ios::app);

void DFS(int u,int t,int PathLen)
{
    vis[u] = t;
    Path[t] = u;
    if (t >= PathLen)
        return;
    int indV=rand()%Degree[u];
    int e=Head[u];
    for (int i=0; i<indV; ++i)
        e = Edge[e].next;
    int v = Edge[e].v;
    for (int count=0; count<100; ++count)
    {
        if (!vis[v])
            break;
        indV=rand()%Degree[u];
        e=Head[u];
        for (int i=0; i<indV; ++i)
            e = Edge[e].next;
        v = Edge[e].v;
    }
    if (!vis[v])
    {
        vis[v] = t;
        DFS(v, t + 1,PathLen);
        vis[v] = 0;
    }
    return;
}
void resDFS(int u, int t, int PathLen)
{
    vis[u] = t;
    resPath[t] = u;
    if (t >= PathLen)
        return;
    for (int e=resHead[u]; e!=-1; e=resEdge[e].next)
    {
        int v = resEdge[e].v;
        if (!vis[v])
        {
            vis[v] = t;
            resDFS(v, t + 1, PathLen);
            vis[v] = 0;
        }
    }

    return;
}
void AddEdge(int u, int v){
   //Add Edge
    edgeNum++;
    Edge[edgeNum].v = v;
    Edge[edgeNum].u = u;
    Edge[edgeNum].next = Head[u];
    Head[u] = edgeNum;
    Degree[u]++;
    return;
}
void AddResEdge(int u, int v)
{
    // Add Edge
    edgeResNum++;
    resEdge[edgeResNum].v = v;
    resEdge[edgeResNum].u = u;
    resEdge[edgeResNum].next = resHead[u];
    resHead[u] = edgeResNum;
    resDegree[u]++;
    return;
}
long long CalcHash(int PathLen)
{
    long long res = 0;
    int len = 0;
    for (int i = 1; Path[i]; ++i)
    {
        res = res * MAXN % MOD + Path[i];
        ++len;
    }
    if (len != PathLen)
        return -1;
    int u = Path[len];
    for (int e = Head[u]; e != -1; e = Edge[e].next)
    {
        int v = Edge[e].v;
        if (v == Path[1])
            return res;
    }
    return -1;
}
long long CalcResHash(int PathLen)
{
    long long res = 0;
    int len = 0;
    for (int i = 1; resPath[i]; ++i)
    {
        res = res * MAXN % MOD + resPath[i];
        ++len;
    }
    if (len != PathLen)
        return -1;
    int u = resPath[len];
    for (int e = resHead[u]; e != -1; e = resEdge[e].next)
    {
        int v = resEdge[e].v;
        if (v == resPath[1])
            return res;
    }
    return -1;
}

int ChechResHamiton(int PathLen)
{
    bool exist[MAXN];
    nodeNum=0;
    edgeResNum = 0;
    for (int i = 0; i < MAXN; ++i)    exist[i] = false;
    for (int i = 0; i <MAXN; ++i)    node[i]=0;
    for (int i = 0; i < MAXN; ++i)    resHead[i] = -1;
    for (int i = 0; i < MAXN; ++i)    resPath[i] = 0;
    for (int i = 0; i < MAXN; ++i)    resDegree[i] = 0;
    for (int i = 1; i <= PathLen; ++i)    exist[Path[i]] = true;
    exist[5] = false;
    for (int i=0; i<MAXN; ++i)  vis[i]=false;
    node[nodeNum++] = 5;
    for (int i=1; i<=n; ++i)
        if (!exist[i])
            node[nodeNum++] = i;
    --nodeNum;
    for (int e=1; e<=m; ++e)
    {
        int u = Edge[e].u, v = Edge[e].v;
        if (!exist[u]&&!exist[v])
            AddResEdge(u, v);
    }
    for (int i=0; i<PathTry; ++i)
    {
        resDFS(node[0], 1, nodeNum);
        if (CalcResHash(nodeNum) > 0)
            return node[0];
    }
    return 0;
}

void Print(int PathLen)
{
    for (int i=1; i<=PathLen; ++i)
        cout << Path[i] << ",";
    cout << 5 << std::endl;
    return;
}
void PrintRes(int nodeNum,int root)
{
    for (int i=1; i<=nodeNum; ++i)
        cout << resPath[i] << ",";
    cout << root << std::endl;
    return;
}

void InitGraph()
{
    //init
    fin >> n >> m;
    for (int i=0; i<MAXN; ++i)
        Head[i] = -1;
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
    for (int PathLen=n-2; PathLen>3; --PathLen)
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
                    int resRoot = ChechResHamiton(PathLen);
                    if (resRoot)
                    {
                        Print(PathLen);
                        PrintRes(nodeNum,resRoot);
                    }
                    cout.flush(); // 将数据刷新到文件中
                }
            }
        }
    }
    return;
}

int main()
{
    freopen("Hamilton3.csv", "w", stdout);
    std::ios_base::sync_with_stdio(false);
    srand(time(NULL));
    InitGraph();
    Solve(5);
    return 0;
}