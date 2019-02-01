//
// Created by aso on 1/30/19.
//

#include "B.h"
#include <iostream>
#include <cmath>

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