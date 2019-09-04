#include "A.h"
#include <iostream>
#include <cmath>

using std::cout;
using std::cin;
using std::endl;

void A_1() {
    const int SIZE = 10;
    double sum_n = 0, sum_p = 0, a[SIZE] = {-1.75, -4, -5.4, 3.2, 5, -3, -32, 32.005}; // выделится память на 2 лишних эл-та. Компилятор вставит 0

    cout << "Array is: ";
    for (int i = 0; i < SIZE; i++) {
        cout << a[i] << " ";

        if (a[i] <= 0)
            sum_n += a[i];
        else sum_p += a[i];
    }
    cout << endl;

    cout << "Positiv sum == " << sum_p << endl;
    cout << "Negativ sum == " << sum_n << endl;
}