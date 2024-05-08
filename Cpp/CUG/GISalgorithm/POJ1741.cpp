#include<iostream>
#include<vector>
#include<memory>

using std::vector;
using std::cin;
using std::shared_ptr;
using NodeType = std::pair<vector<int>,int>;

class Edge{
    int node,length;
    shared_ptr<Edge> next;
    public:
    Edge(int node,int length,shared_ptr<Edge> u):
        node(node),length(length){
            next = u;
            u = shared_ptr<Edge>(this);
        }
    shared_ptr<Edge> getNext(){return next;}
    int getNode(){return node;}
    int getLength(){return length;}
};

vector<int> build(int node,int limit,vector<shared_ptr<Edge>>& heads,vector<shared_ptr<Edge>>& edges){
    vector<int> count(limit+1);
    for (int i = 0; i <= limit; i++)    count[i] = 0;
    count[0] = 1; //the distance from node to itself is 0
    vector<NodeType> subCounts;
    //bool length[limit+1];
    for (shared_ptr<Edge> edge = heads[node]; edge!=nullptr; edge = edge->getNext()){
        int v = edge->getNode();
        //length[edge->getLength()] = true;
        subCounts.push_back(std::make_pair(build(v,limit,heads,edges),edge->getLength()));
    }

    for (vector<NodeType>::iterator start = subCounts.begin(); start!=subCounts.end(); start++){
        vector<int> count1 = (*start).first;
        int leastCost = (*start).second;
        {//consider the father node as the terminial node
            for (int i = 0; i <= limit - leastCost; i++)
                count[i + leastCost] += count1[i];
        }
        for (vector<NodeType>::iterator end = start+1; end!=subCounts.end(); end++){
            //consider another subtree where contains the terminial node
            vector<int> count2 = (*end).first;
            leastCost += (*end).second;
            for (int k = 0; k <= limit - leastCost; k++){
                for (int i = 0; i <= k; i++){
                    count[k + leastCost] += count1[i] * count2[k-i];
                }
            }

        }
    }
    return count;
}
void solve(int nodeNum,int edgeNum,int k){
    vector<shared_ptr<Edge>> heads(nodeNum+1);
    vector<shared_ptr<Edge>> edges;
    while (edgeNum--){
        int u,v,l;
        cin>>u>>v>>l;
        edges.push_back(std::make_shared<Edge>(v,l,&heads[u]));
        edges.push_back(std::make_shared<Edge>(u,l,&heads[v]));
    }
    vector<int> count(k+1);
    count = build(1,k,heads,edges);

    int ans = 0;
    for (std::vector<int>::iterator it = count.begin(); it != count.end(); it++)
        ans += *it;
    std::cout<<ans<<std::endl;
}
int main(){
    int n,k;
    while (cin>>n>>k){
        if (n == 0 && k == 0) break;
        solve(n,n-1,k);
    }
    return 0;
}