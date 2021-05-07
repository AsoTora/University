//
// Created by aso on 1/30/19.
//

#include "A.h"
#include "iostream"

using namespace std;

/*
Ввести с клавиатуры одномерный массив. Решить задачу путем рекурсивного разбиения массива
на две части. Для контроля решить задачу с использованием циклического алгоритма.
*/

int count(int arr[], int i, int j){
    if (i==j)
        return arr[i]>0; // 1 or 0
    return count(arr,(i+j)/2+1, j) + count(arr, i, (i+j)/2);
}

void A_1(){ // Найти количество отрицательных элементов массива
    int arr[] = {-11, -22, -3, 10, 4, 5};
    cout << count(arr, 0, 5) << endl;

    int c=0; // loop
    for (int i : arr) {
        c += i > 0;
    }
    cout << c << endl;
}

int even(int arr[], int i, int j){
    if (i==j)
        return arr[i]%2==0;
    return even(arr,(i+j)/2+1, j) + even(arr, i, (i+j)/2);
    }

void A_3(){ // Найти количество четных элементов массива.
    int arr[] = {1, 2, 3, 4, 6, 6, 6};
    cout << even(arr, 0, 6) << endl;

    int c=0; // loop
    for (int i : arr) {
        if (i%2==0) c++;
    }
    cout << c << endl;
}

bool negative(int *arr, int i, int j){
    if (i==j)
        return arr[i] < 0;
    return negative(arr,(i*2+j)/3+1, j) || negative(arr, i, (i*2+j)/3);
}

void A_6(){ //
    /*Определить, встречаются ли отрицательные элементы в массиве.
При рекурсивном разбиении массив делить на первые 2/3 и остальную треть массива.*/
    int arr[] = {1, 2, 3, 4, 6, -5, 6};
    cout << negative(arr, 0, 6) << endl;

    bool b = false;
    for (int i : arr) { // loop
        if (i < 0){
            b = true; break;
        }
    }
    cout << b << endl;
}
