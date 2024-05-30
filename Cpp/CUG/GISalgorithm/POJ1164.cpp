#include<iostream>
#include<vector>
#define _DIRECTION 15

struct node{
    int avliable;
    bool visited;
};
const int dx[4] = {-1,0,1,0};
const int dy[4] = {0,1,0,-1};

void init(std::vector<std::vector<node> > &mat,const int n,const int m){
    for (int i = 0; i < n; i++){
        for (int j = 0; j < m; j++){
            int x;
            std::cin>>x;
            mat[i][j].avliable = x ^ _DIRECTION;
            mat[i][j].visited = false;
        }
    }
}
int DFS(std::vector<std::vector<node> > &mat,const int &n,const int &m,int x,int y){
    mat[x][y].visited = true;
    int res = 0;
    for (int d = 0; d < 4; d++){
        int code = 1 << d;
        if (mat[x][y].avliable & code){
            int ox = x + dx[d], oy = y + dy[d];
            if (ox >= 0 && ox < n && oy >= 0 && oy < m && !mat[ox][oy].visited)
                res += DFS(mat,n,m,ox,oy);
        }
    }
    return res;
}
int main(){
    int n,m;
    std::cin>>n>>m;
    std::vector<std::vector<node> > mat(n);
    std::vector<int> roomSize;
    init(mat,n,m);
    for (int i = 0; i < n; i++)
        for (int j = 0; j < m; j++)
            if (!mat[i][j].visited)
                roomSize.push_back(DFS(mat,n,m,i,j));
    std::cout<<roomSize.size()<<std::endl;
    std::cout<<*std::max_element(roomSize.begin(),roomSize.end());
    return 0;
}