//
// Created by aso on 2/4/19.
//

#include "A.h"
#include <iostream>

// Задания в А части -- копирование функций сортировки из теоретического раздела.
// Для этого можно воспользоваться любым онлайн-ресурсом с автоматической системой тестирования.

void sort(int arr[], int n){
    /* Sort function here*/

}

/* Prints the array */
void printArray(int a[], int n){
    for (int i = 0; i < n; i++)
        printf("%d ", a[i]);
    printf("\n");
}

// Main
void func(){
    int arr[] = { 5, 1, 4, 2, 8, 0, 2 };
    int n = sizeof(arr) / sizeof(arr[0]);
    // sort(arr, n);
    printf("Sorted array :\n");
    printArray(arr, n);
}