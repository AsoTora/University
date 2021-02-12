#include "B.h"
#include <iostream>
#include <cmath>

using std::cout;
using std::cin;
using std::endl;

void task_B_1_min_max() {
    const int SIZE = 10;
    int arr[SIZE];

    cout << "Enter array: \n";
    for (int i = 0; i < SIZE; i++) {
        cout << "[" << i << "]" << ":";
        cin >> arr[i];
    }

    cout << endl << "Array before is: ";
    for (int i = 0; i < SIZE; i++)
        cout << arr[i] << " ";
    cout << endl;

    int temp; // временная переменная для сортировки
    for (int i = 0; i < SIZE; i++) { // эл-т i и все остальные
        for (int j = 0; j < SIZE-1; j++) { // перебор всех эл-тов после и включая эл-т i
            if (fabs(arr[j]) > fabs(arr[j + 1])) {
                temp = arr[j]; // cохраняю значение переменной
                arr[j] = arr[j + 1]; // поставить меньшую переменную на место большей
                arr[j + 1] = temp; // поставить большую переменную на место меньшей
            }
        }
    }

    cout << endl << "Array after is: ";
    for (int i = 0; i < SIZE; i++)
        cout << arr[i] << " ";
    cout << endl;

}
