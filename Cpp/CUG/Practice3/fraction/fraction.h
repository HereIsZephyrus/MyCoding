/***
 * @Author: ChanningTong Channing_TongCN@outlook.com
 * @Date: 2023-04-22 17:48:52
 * @LastEditors: ChanningTong Channing_TongCN@outlook.com
 * @LastEditTime: 2023-04-23 17:09:26
 * @FilePath: \Practice3\fraction\fraction.h
 * @Description:
 * @
 * @Copyright (c) 2023 by ChanningTong, All Rights Reserved.
 */
#pragma once
#include <iostream>
class fraction{
    private:
        struct Number{
            int numerator; // 分子
            int denominator; // 分母
        }value;
        int gcd(int a, int b) const{
            return b == 0 ? a : gcd(b, a % b);
        } // 求最大公约数
    protected:
        Number simplify(Number x){
            int m = gcd(x.numerator, x.denominator);
            x.numerator /= m;
            x.denominator /= m;
            return x;
        } // 约分
        Number standlize(double num) const{
            Number Res={0,1};
            for (int counting=0; ((counting<9) && (num !=int(num))); ++counting){
                num *= 10;
                Res.denominator *= 10;
            }
            Res.numerator = int(num);
            return Res;
        } // 标准化(分子分母都为整数
    public:
        fraction(int num = 0, int den = 1): value{num, den}{
            value = std::move(simplify(value));
        };
        fraction(double num):value{0,1}{
            value=std::move(simplify(standlize(num)));
        }
        fraction(double num, double den):value{0,1}{
            value=std::move(simplify(standlize(num/den)));
        }
        ~fraction()=default;
        friend fraction operator+(const fraction &f1, const fraction &f2){
            fraction Res = {0, 1};
            Res.value.numerator = (long long)f1.value.numerator * f2.value.denominator + (long long)f2.value.numerator * f1.value.denominator;
            Res.value.denominator =f1.value.denominator* f2.value.denominator;
            Res.value=Res.simplify(Res.value);
            return Res;
        }
        friend fraction operator-(const fraction &f1, const fraction &f2){
            fraction Res = {0, 1};
            Res.value.numerator = (long long)f1.value.numerator * f2.value.denominator - (long long)f2.value.numerator * f1.value.denominator;
            Res.value.denominator = f1.value.denominator* f2.value.denominator;
            Res.value = Res.simplify(Res.value);
            return Res;
        }
        friend fraction operator*(const fraction &f1, const fraction &f2){
            fraction Res = {0, 1};
            Res.value.numerator = (long long)f1.value.numerator * f2.value.numerator;
            Res.value.denominator =f1.value.denominator * f2.value.denominator;
            Res.value = Res.simplify(Res.value);
            return Res;
        }
        friend fraction operator/(const fraction &f1, const fraction &f2){
            fraction Res = {0, 1};
            Res.value.numerator = (long long)f1.value.numerator * f2.value.denominator;
            Res.value.denominator =f1.value.denominator * f2.value.numerator;
            Res.value = Res.simplify(Res.value);
            return Res;
        }

        template <typename Num>//使用模板类简化重载
        friend fraction operator+(const Num &d, const fraction &f){
            fraction tmp(d);
            return tmp + f;
        }
        template <typename Num>
        friend fraction operator-(const Num &d,const fraction &f){
            fraction tmp(d );
            return tmp - f;
        }
        template <typename Num>
        friend fraction operator*(const Num &d,const fraction &f){
            fraction tmp(d );
            return tmp * f;
        }
        template <typename Num>
        friend fraction operator/(const Num &d,const fraction &f){
            fraction tmp(d );
            return tmp / f;
        }

        template <typename Num>
        friend fraction operator+(const fraction &f, const Num &d){
            fraction tmp(d);
            return f + tmp;
        }
        template <typename Num>
        friend fraction operator-(const fraction &f,const Num &d){
            fraction tmp(d);
            return f-tmp;
        }
        template <typename Num>
        friend fraction operator*(const fraction &f,const Num &d){
            fraction tmp(d);
            return tmp * f;
        }
        template <typename Num>
        friend fraction operator/(const fraction &f,const Num &d){
            fraction tmp(d);
            return f/tmp;
        }

        friend std::istream& operator>>(std::istream &is, fraction &f){
            std::cout<<"Please input the numerator and denominator:"<<std::endl;
            double num, den;
            is >> num >> den;
            f = fraction(num, den);
            return is;
        }
        friend std::ostream& operator<<(std::ostream &os, const fraction &f){
            os << f.value.numerator << "/" << f.value.denominator;
            return os;
        }
        operator double() const{
            return double(value.numerator)/double(value.denominator);
        }
        operator int() const{
            return int(value.numerator / value.denominator);
        }
};