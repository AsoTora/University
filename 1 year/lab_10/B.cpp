//
// Created by aso on 1/30/19.
//

#include "B.h"
#include <iostream>
#include <cmath>
#include <string>

using namespace std;

/*Решить задачу двумя способами – с применением рекурсии и без нее.*/

int mult_main(int a, int b){  // рекурсивно сумма
    if (b == 0)
        return 0;
    if (b == 1)
        return a;
    return a+mult_main(a, b-1);
}

int mult(int a, int b){  // проверка на отрицательность
    bool neg = false;
    if ((b>0 && a<0) || (b<0 && a>0))
        neg = true;
    if (neg)
        return -mult_main(abs(a), abs(b));
    return mult_main(abs(a), abs(b));
}

void B_1(){ // Написать функцию умножения двух чисел, используя только операцию сложения.
    int a=-7, b=-3;
    cout << mult(a, b) << endl;

    int m=0;  // loop
    bool neg = false;
    if ((b<0 && a>0) || (b<0 && a<0))
        neg = true;
    for (int i = abs(b); i != 0 ; i--) {
        if (!neg)
            m += a;
        else
            m-=a;
    }
    cout << m << endl;
}

int sum(int n){
    if (n%10==n)
        return n;
    return sum(n/10)+n%10;
}

void B_5(){  // Подсчитать сумму цифр в десятичной записи заданного числа.
    int n = 12345;
    cout << sum(n) << endl;
}

double y(int n, int i=1){
    /*
    * n=1 --> sqrt(n)
    * n=2 --> sqrt(n-1 + sqrt(n))
    * n=3 --> sqrt(n-2 + sqrt(n-1 +sqrt(n)))
    */
    if (n==i)
        return sqrt(i);
    return sqrt(y(n, i+1)+i);
}

void B_10(){ // Вычислить y(n) = sqrt(1 +sqrt(2 + ... sqrt(n-1)+ sqrt(n))))
    int n=5;
    cout << y(n) << endl;
}

bool check(string str, int start, int end){
    if (start >= end)
        return true;
    if (str[start] != str[end])
        return false;
    return check(str, ++start, --end);
}

void B_8(){
    string str = "step on no pets";
    cout << str << " " << check(str, 0, str.length()-1) << endl;
}

double f(double x){
    return 7*sin(x)*sin(x);
}

double func(double e, double a, double b){
    double c = (a+b)/2;
    if (abs(b-a) > e){
        double x1 = func(e, a, c);
        double x2 = func(e, c, b);
        if (f(x1) < f(x2))
            return x1;
        else
            return x2;
    }
    return c;
}

void B_6(){
    double  e = 0.01, a=2, b=6;
    cout << "f(x) = " << func(e, a, b) << endl;
}