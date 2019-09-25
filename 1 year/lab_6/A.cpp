//
// Created by aso on 10/22/18.
//

#include "A.h"
#include <iostream>
#include <iomanip>
#include <cmath>

using namespace std;

double y_1(double x, int &n); // прототип функции для А_1()
double y_2(double x, int n); // прототип функции для А_2()

void A_1(){/*
	 * Вывести на экран таблицу значений функции y(x, n) для x, изменяюще-
гося от a до b с шагом h = (b – a)/10. Расчет y(x, n) поместить в функцию. Па-
раметры передавать указанным в табл. II способом.*/
	double a=0.13,x, b=0.9, h;
	int n = 10;
	h = (b-a)/10;

	for (x=a; x<b-h/2; x+=h){
		cout << "x= " << x << setw(15) << "y(x,n)= " << y_1(x, n) << endl;
	}

}

double y_1(double x, int &n){
	double sum = 0, temp=1;

	for (int i = 1; i<=n; i++){
		temp *= exp(x);
		sum += 3*temp;
	}
	x++;
	return sum + n*cos(x)/sin(x); // чтобы лишних n раз не считать ctg(x)
}

// ====================================================

void A_2(){/*
    * Вывести на экран таблицу значений функции y(x, n) для x, изменяюще-
гося от a до b с шагом h = (b – a)/10. Расчет y(x, n) поместить в функцию. Па-
раметры передавать указанным в табл. II способом.*/
	double a=0.24,x, b=1.2, h;
	int n = 8;
	h = (b-a)/10;

	for (x=a; x<b-h/2; x+=h){
		cout << "x= " << x << setw(15) << "y(x,n)= " << y_2(x, n) << endl;
	}
}

double y_2(double x, int n){
	double sum = 0, temp = 1;
	double p = sin(x); // чтобы лишних n раз не считать sin(x)

	for (int i = 1; i<=n; i++) {
		temp *= exp(-i*p);
		sum += temp;
	}

	return sum + n*sqrt(fabs(sin(2*x))); // чтобы лишних n раз не считать
}
