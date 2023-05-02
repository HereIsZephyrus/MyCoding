/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-14 19:28:55
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-05-02 10:43:16
 * @FilePath: \Practice1\4.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-03-14 19:07:11
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-03-14 20:01:15
 * @FilePath: \CUG\Practice1\4.cpp
 * @Description:
 * @
 * @Copyright (c) 2023 by ${git_name_email}, All Rights Reserved.
 */
#include<iostream>
#include<ctime>
#include<cstdlib>
using namespace std;

int main(){
    srand((unsigned int)time(0));
    int num=rand()%100;
    int Guess=-1;
    cout<<"I generate a number just now.Can you catch it?It ranges 0 to 99"<<endl;
    cin>>Guess;
    while (Guess!=num){
        cout << "Pity!Not the number.";
        if (Guess<num) cout<<"Try a larger one."<<endl;
        if (Guess>num) cout<<"Try a smaller one."<<endl;
        cin>>Guess;
    }
    cout<<"You are right!"<<endl;
    cin.get();
    cin.get();
    return 0;
}