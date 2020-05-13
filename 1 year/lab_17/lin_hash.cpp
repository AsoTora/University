//
// Created by aso on 3/29/19.
//

#include "lin_hash.h"
#include <iostream>
#include <cmath>

void add(int *h_table, int data, int size=10){
    int pos = data%10;
    if (h_table[pos] != -1){ // если ячейка занята
        int c = 0;
        while(h_table[pos] != -1){
            pos++, c++;
            if (pos == 10) pos = 0;
            if (c > 10) return;
        }
    }
    h_table[pos] = data;
}
int search(const int *h_table, int data, int size=10){
    int pos = abs (data % 10);
    while(h_table[pos] != -1){
        if (h_table[pos] == data) return pos;
        pos++;
        if (pos > 10) pos = 0;
    }
    return -1;
}

int lin_hash() {
    int arr[] = {1, 2, 3, 44, 6, 22, 5, 32};
    int size = 10; // hash-table size
    int h_table[size];

    for (int i = 0; i < size; ++i) {  // сделать пустую хэш-таблицу
        h_table[i] = -1;
    }

    for (int j : arr) {  // добавить элементы arr в нее
        add(h_table, j);
    }

    int c = 0, pos;
    while (c != -1){
        std::cin >> c;
        pos = search(h_table, c);
        if (pos == -1) std::cout << "This num doesnt registered" << std::endl;
        else std::cout << pos << std::endl;
    }
    return 0;
}