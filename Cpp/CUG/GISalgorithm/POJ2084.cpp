#include <iostream>
#include <string>
#include <vector>
// #define ull unsigned long long
const int MAXN = 110;
using std::cin;

class BigInteger{
private:
    std::vector<int> digits;
public:
    BigInteger() {}
    BigInteger(int num){for (int i = num; i; i /= 10)    digits.push_back(i % 10);}
    BigInteger(const std::vector<int> &nums) : digits(nums) {}

    BigInteger operator+(const BigInteger &other) const{
        std::vector<int> result;
        int carry = 0;
        int i = 0, j = 0;
        while (i < digits.size() || j < other.digits.size() || carry != 0){
            int sum = carry;
            if (i < digits.size())          sum += digits[i++];
            if (j < other.digits.size())    sum += other.digits[j++];
            result.push_back(sum % 10);
            carry = sum / 10;
        }
        return BigInteger(result);
    }

    BigInteger operator*(const BigInteger &other) const{
        std::vector<int> result(digits.size() + other.digits.size(), 0);
        for (int i = 0; i < digits.size(); ++i){
            int carry = 0;
            for (int j = 0; j < other.digits.size() || carry != 0; ++j){
                int product = result[i + j] + carry + digits[i] * (j < other.digits.size() ? other.digits[j] : 0);
                result[i + j] = product % 10;
                carry = product / 10;
            }
        }
        return BigInteger(result);
    }

    friend std::ostream &operator<<(std::ostream &os, const BigInteger &bigint){
        for (std::vector<int> ::const_reverse_iterator it = bigint.digits.rbegin(); it != bigint.digits.rend(); ++it)
            os << *it;
        return os;
    }
} C[MAXN];

int main()
{
    int n;
    for (int n = 0; n < MAXN; n++)
        C[n] = BigInteger(0);
    for (int n = 2; n < MAXN; n++)
        for (int i = 1; i <= n; i++)
            C[n] = C[n] + C[n - i] * C[i];
    while (cin >> n){
        if (n == -1)
            break;
        std::cout << C[n] << std::endl;
    }
    return 0;
}