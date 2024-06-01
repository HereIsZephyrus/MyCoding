#include<iostream>
#include<vector>
#include<queue>
using std::vector;
using std::queue;
using std::cin;
using std::iterator;
using std::cout;
static int restAttacker;
namespace SoldierType{
    const static int lancer = 0;
    const static int cavalier = 1;
    const static int halberdiers = 2;
};
const int multiplier[3][3] = {
    {1,2,1},
    {1,1,2},
    {2,1,1}
};
const int dx[4] = {0,0,1,-1};
const int dy[4] = {1,-1,0,0};

class Troop{
    int type,id;
    int x,y;
    bool isEnermy;
public:
    int number;
    bool attacked;
    Troop():type(SoldierType::lancer),number(0),x(0),y(0),isEnermy(false),attacked(false),id(0){}
    Troop(int type,int number,int x,int y,bool isEnermy,int count):type(type),number(number),x(x),y(y),isEnermy(isEnermy),attacked(false),id(count){}
    int getType() const {return type;}
    int getNumber() const {return number;}
    int getX() const {return x;}
    int getY() const {return y;}
    bool getIsEnermy() const {return isEnermy;}
    int getID() const {return id;}
};
struct AllowAttackLocation{
    int x,y;
    vector<Troop*> attackers;
    Troop* casualty;
    AllowAttackLocation(int x, int y, vector<Troop*> attackers, Troop* casualty) :x(x), y(y), attackers(attackers), casualty(casualty) {}
};
struct Node{
    int x,y,step;
    Node(int x, int y, int step) :x(x), y(y), step(step) {}
};

char getBlock(){
    char c;
    c = getchar();
    while (c < 'A' || c > 'X') c = getchar();
    return c;
}
Troop getTroop(char c,const int x,const int y,size_t count){
    int type = (c-'A')%3;
    bool isEnermy = (c - 'A') / 3;
    int number = 0;
    char i = getchar();
    while (i >= '0' && i <= '9'){
        number = number * 10 + i - '0';
        i = getchar();
    }
    return Troop(type,number,x,y,isEnermy,(int)count+1);
}
vector<Troop *> reachableTroops(const vector<vector<int>> &map, vector<Troop> &allTroops, const int x, const int y, const int AM[]){
    const int n = map.size(),m = map[0].size();
    vector<Troop*> accessibleTroops;
    vector<vector<bool> > visited(n,vector<bool>(m,false));
    //use bfs to find all the troops that can be attacked
    queue<Node> q;
    q.push(Node(x,y,0));
    visited[x][y] = true;
    while (!q.empty()){
        int sx = q.front().x,sy = q.front().y,step = q.front().step;
        if (map[sx][sy] > 0){
            Troop *t = &allTroops[map[sx][sy] - 1];
            if (!t->getIsEnermy() && AM[t->getType()] >= step) //this is noe enermy and the AM is long enough
                accessibleTroops.push_back(t);
        }
        q.pop();
        for (int d = 0; d < 4; d++){
            int nx = sx + dx[d];
            int ny = sy + dy[d];
            if (nx < 0 || nx >= n || ny < 0 || ny >= m) continue;
            if (visited[nx][ny] || map[nx][ny] < 0) continue;
            if (map[nx][ny] == 0 || !allTroops[map[nx][ny] - 1].getIsEnermy()) {//if this is passable block
                q.push(Node( nx,ny,step + 1 ));
                visited[nx][ny] = true;
            }
        }
    }
    return accessibleTroops;
}
int maxDamage(vector<AllowAttackLocation> &locations,int index,const int AA[],vector<vector<bool>> &occupied){
    if (restAttacker == 0) return 0;
    if (index == locations.size()) return 0;
    //dont take attack at this position
    int max = maxDamage(locations, index + 1, AA,occupied);
    //take attack at this position
    Troop *casualty = locations[index].casualty;
    for (vector<Troop*>::iterator attacker = locations[index].attackers.begin(); attacker != locations[index].attackers.end(); attacker++){
        if ((*attacker)->attacked) continue;
        bool isAdjacent = ((*attacker)->getX() == locations[index].x) && ((*attacker)->getY() == locations[index].y);
        if (!isAdjacent && occupied[locations[index].x][locations[index].y])
            continue;
        // take attack
        (*attacker)->attacked = true;
        restAttacker--;
        int attackerNumber = (*attacker)->getNumber();
        int multi = multiplier[(*attacker)->getType()][casualty->getType()];
        int damage = std::min((int)multi * attackerNumber * AA[(*attacker)->getType()], casualty->number);
        casualty->number -= damage;
        //change occupied
        occupied[locations[index].x][locations[index].y] = true;
        occupied[(*attacker)->getX()][(*attacker)->getY()] = false;
        max = std::max(max,damage + maxDamage(locations,index+1,AA,occupied));
        //undo attack
        (*attacker)->attacked = false;
        restAttacker++;
        casualty->number += damage;
        //change occupied
        occupied[locations[index].x][locations[index].y] = false;
        occupied[(*attacker)->getX()][(*attacker)->getY()] = true;
    }
    return max;
}

void init(vector<vector<int> > &map,vector<Troop> &troops){
    const int n = map.size(),m = map[0].size();
    for (int i = 0; i < n; i++)
        for (int j = 0; j < m; j++){
            char c = getBlock();
            if (c  == 'X')      map[i][j] = -1;
            else if (c == 'O')  map[i][j] = 0;
            else{
                Troop t = getTroop(c,i,j,troops.size());
                troops.push_back(t);
                if (!t.getIsEnermy()) restAttacker++;
                map[i][j] = t.getID();
            }
        }
    return;
}
int main(){
    int AM[3],AA[3];
    cin>>AM[SoldierType::lancer]>>AM[SoldierType::cavalier]>>AM[SoldierType::halberdiers];
    while (AM[0] + AM[1] + AM[2]){
        restAttacker = 0;
        cin>>AA[SoldierType::lancer]>>AA[SoldierType::cavalier]>>AA[SoldierType::halberdiers];
        int n,m;
        cin>>n>>m;
        vector<vector<int> > map(n,vector<int>(m)); //-1 means not accessible, 0 means empty, other means the id of the troop
        vector<Troop> troops;
        init(map,troops);
        //solve
        vector<AllowAttackLocation> locations;
        for (vector<Troop>::iterator it = troops.begin(); it != troops.end(); it++){
            if (!it->getIsEnermy()) continue;
            for (int d = 0; d < 4; d++){
                int x = it->getX() + dx[d];
                int y = it->getY() + dy[d];
                if (x < 0 || x >= n || y < 0 || y >= m) continue;
                if (map[x][y] < 0)    continue;
                if (map[x][y]==0 || !troops[map[x][y]-1].getIsEnermy())
                    locations.push_back(AllowAttackLocation(x,y,reachableTroops(map,troops,x,y,AM),&(*it)));
            }
        }
        vector<vector<bool>> occupied(n, vector<bool>(m, false));
        for (vector<Troop>::iterator it = troops.begin(); it != troops.end(); it++) {
            if (it->getIsEnermy()) continue;
            occupied[it->getX()][it->getY()] = true;
        }
        std::cout << maxDamage(locations, 0, AA, occupied) << std::endl;
        //nextturn
        cin>>AM[SoldierType::lancer]>>AM[SoldierType::cavalier]>>AM[SoldierType::halberdiers];
    }
    return 0;
}