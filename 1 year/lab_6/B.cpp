//
// Created by aso on 10/22/18.
//

#include "B.h"
#include <iostream>
#include <iomanip>
#include <cmath>

using namespace std;

// B_1
void s_1(double& , double&, int);

//B_2
typedef double user_f(double, double*, int*);
void tabl(double*, double*, double*, double*, user_f);
double y_3(double, double*, int*);
double s_3(double, double *, int*);


void B_1(){/*
 Вывести на экран таблицу значений функции и ее разложения в ряд
для x, изменяющегося от a до b с шагом h = (b – a)/10. Расчет y(x) и s(x) по-
местить в функцию. Использовать прототипы функций. Параметры переда-
вать указанным в табл. III способом. Расчет функции s(x) выполнить с заданной точностью.
Способ передачи параметров: по ссылке.
Функция: ln(x)
2*/
    double a=0.8, b=1.8, h=(b-a)/10, e=10e-4;
    int n=1;

    for (double x=a; x<b+h/2; x+=h){
        cout << setw(7) << "x= "<< x << setw(15) <<"y(x)= "<< log(x) << setw(10);
        s_1(x, e, n);
    }
}

void s_1(double &x, double &e, int n) {
    double sum=0, t=1;
    while (fabs(t)>e)
    {
        t *= -(x-1); // реккурентный член
        sum += -t/n;
        n++;
    }
    cout << "s(x)= " << sum << setw(5) << "n= " << n << endl;
}


// ==================================================
// ==================================================
// ==================================================


void B_3(){
    double a =-0.99, b=0, h=(b-a)/10, e=1e-12;

    cout << setw(8) <<"x"<< setw(15) <<"y(x)"<< setw(10) << "k" << endl;
    tabl(&a,&b,&h,&e,y_3);
    cout << endl;

    cout << setw(8) <<"x"<< setw(15) <<"s(x)"<< setw(10) << "k" <<endl ;
    tabl(&a,&b,&h,&e,s_3);

}

void tabl(double *a, double *b, double *h, double *e, user_f func)
{
    int k=0;
    double sum;
    for (double x=*a; x<*b-*h/2; x+=*h)
    {
        sum =  func(x,e,&k);
        cout << setw(8) << x << setw(15) << sum << setw(10) << k << endl;
    }
}

double y_3(double x, double *e, int *k){
    return 1/(1+x);
}

double s_3(double x, double *e, int *k){
    double sum=1, t=1;

    while (fabs(t) > *e){
        t *= -(x);
        sum += t;
        (*k)++;
    }

    return sum;
}