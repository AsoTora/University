//
// Created by aso on 2/5/19.
//

#include "A.h"
#include <string>

/* Задан отсортированный по неубыванию массив целых чисел. Вывести
на экран номер элемента с заданным ключом или информацию о том, что та-
кого элемента в массиве нет. Поиск вести указанным методом.

 // Задание бесполезно, здесь написаны алгоритмы поиска для всех вариантов.
*/

int linear(int arr[], int size, int key){
    for (int i=0; i <size; i++ ){  // сравнение 1
        if (arr[i] == key) // сравнение 2
            return i;
    }
    return -1;
}

int linear_navr(int arr[], int size, int key){
    arr[size] = key; // ???
    int i = 0;
    while(arr[i] != key) i++;
    if (i == size) return -1;
    else return i;
}


int linear_pro(int arr[], int size, int key){
    int last = arr[size-1]; // запоминаю посл эл-т;
    arr[size-1] = key;

    int i = 0;
    while(arr[i] != key) i++;
    arr[size-1] = last; // восстановить массив

    if (i != size-1 || key == last)
        return i;
    return -1;
}

int binarySearch_iter(int arr[], int size, int key){
    int m, right = size-1, left=0;
    while (left < size){
        m = (left+right)/2;
        if (key < arr[m])
            right = m-1;
        else if (key > arr[m])
            left = m+1;
        else return m; // значит попали на значение
    }
    return -1;
}

int binarySearch_recursive(int arr[], int l, int r, int x) {
    if (r >= l) {
        int mid = l + (r - l) / 2;

        if (arr[mid] == x) // ~ базовый случай
            return mid;

        if (arr[mid] > x)
            return binarySearch_recursive(arr, l, mid - 1, x);

        return binarySearch_recursive(arr, mid + 1, r, x);
    }
    return -1;
}

int interpolationsearch(int arr[], int size, int key){
    if (arr[0] == key)
        return 0;

    int left=1, right=size-1, m;
    while(left < right){
        m = left + (right-left)*((key - arr[left])/(arr[right] - arr[left]));
        if (arr[m] == key) return m;
        else
            if (key > arr[m]) left = m+1;
            else right = m-1;
    }
    return -1;
}


// Алгоритмы поиска вполне работают и для класса string:
int linear_pro_str(std::string arr[], int size, const std::string &key){
    std::string last = arr[size-1]; // запоминаю посл эл-т;
    arr[size-1] = key;

    int i = 0;
    while(arr[i] != key) i++;
    arr[size-1] = last; // восстановить массив

    if (i != size-1 || key == last)
        return i;
    return -1;
}

/*
int main() {
    std::string arr[] = {"andrey", "olga", "petr", "belenko"};
    int size = sizeof(arr)/sizeof(arr[0]);

    std::cout << "Your name: " linear_pro_str(arr, size, "petr") << std::endl;
    return 0;
}
// Your name: 2

*/
