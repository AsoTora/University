//
// Created by aso on 10/17/18.
//

#include "Tasks_A.h"
#include <iostream>
#include <cmath>

using std::cout;
using std::endl;
using std::cin;

void A_1() {
    const int ROWS = 5, COLUMNS = 7;
    int arr[ROWS][COLUMNS], n = 0;

    for (int i = 0; i < ROWS; i++) {
        for (int j = 0; j < COLUMNS; j++) {
            cout << "Value of " << "[" << i << "][" << j << "] element: ";
            cin >> arr[i][j];
        }
    }


    for (int i = 0; i < ROWS; i++) {
        for (int j = 0; j < COLUMNS; j++) {
            if (arr[i][j] == 0) {
                n++;
                continue;
            }
        }
    }

    cout << "Answer: " << n << endl;
}
void A_0() {
    const int ROWS = 5, COLUMNS = 7;
    int arr[ROWS][COLUMNS], n = 0;

    for (int i = 0; i < ROWS; i++) {
        for (int j = 0; j < COLUMNS; j++) {
            cout << "Value of " << "[" << i << "][" << j << "] element: ";
            cin >> arr[i][j];
        }
    }


    for (int i = 0; i < ROWS; i++) {
        for (int j = 0; j < COLUMNS; j++) {
            if (arr[j][i] == 0) {
                n++;
                continue;
            }
        }
    }
    cout << "Answer: " << n << endl;

}

void stuff(){
    /*Упорядочить строки матрицы по возрастанию их максималь-
ных элементов. */

    const int n = 3, m = 2;
    int a[n][m], i, j, b[n];

    for (i = 0; i < n; i++) {
        for (j = 0; j < m; j++) {
            cout << "Value of " << "[" << i << "][" << j << "] element: ";
            cin >> a[i][j];
        }
    }

    for (i=0; i<n; i++){
        b[i]=a[i][0];
        for (j=1; j<m; j++)
            if (a[i][j]>b[i])
                b[i]=a[i][j];
    }


    for (i=0; i < n; i++){
        for (j=0; j < n-1; j++){
            if (b[j] > b[j+1]){
                int t = b[j];
                b[j] = b[j+1];
                b[j+1] = t;
            }
        }
    }


    cout << "*****" << endl;
    for (i = 0; i < n; i++) {
        cout << endl;
        for (j = 0; j < m; j++) {
            cout << " " << a[i][j];
        }
    }



}