#include<algorithm>
#include<iostream>
#include<vector>
#include<string>
#include<memory>

int msort(int left,int right,std::vector<int>& value)
{
    if(left>=right)    return 0;
    int mid = left + (right - left) / 2;
    int count = msort(left,mid,value) + msort(mid+1,right,value);
    int i = left, j = mid + 1, k = 0;
    std::vector<int> temp(right-left+1);
    while(i <= mid && j <= right)
    	if(value[i]<=value[j])
    		temp[k++]=value[i++];
    	else{
    		temp[k++]=value[j++];
            count += (mid-i+1);
        }
    while(i<=mid)	temp[k++]=value[i++];
    while(j<=right)	temp[k++]=value[j++];
    for (int i = left; i <= right; i++)
        value[i] = temp[i-left];
    return count;
}

class DNA{
    int len ;
    int revert ;
    std::string DNAstring;
    int calcRevert(){
        std::vector<int> value(len);
        for (int i = 0; i < len; i++)
            value[i] = DNAstring[i] - 'A';
        return msort(0,len-1,value);
    }
public:
    const std::string getDNAstring(){return DNAstring;}
    DNA(int len,std::string DNAstring){
        this->len = len;
        this->DNAstring = DNAstring;
        this->revert = calcRevert();
    }
    bool operator<(const DNA& dna){
        return revert < dna.revert;
    }
};

int main(){
    int len,num;
    std::vector<DNA> DNAs;
    std::cin>>len>>num;
    getchar();
    while(num--){
        std::string DNAstring;
        std::getline(std::cin,DNAstring);
        //std::cout<<DNAstring<<std::endl;
        DNAs.push_back(DNA(len,DNAstring));
    }
    std::sort(DNAs.begin(),DNAs.end());
    for (std::vector<DNA>::iterator it = DNAs.begin(); it != DNAs.end(); it++)
        std::cout << it->getDNAstring() << std::endl;
    return 0;
}