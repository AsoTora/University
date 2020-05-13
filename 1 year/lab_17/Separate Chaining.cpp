//
// Created by aso on 3/29/19.
//

#include "Separate Chaining.h"
#include <iostream>
#include <cmath>
using namespace std;
const int t_size = 10;
const int m = 10;


node **create_table(){
    node **table = new node*[t_size]; // массив списков
    for (int i = 0; i < t_size; ++i) {
        table[i] = nullptr;
    }
    return table;
}

void add(int data, node**table){
    node *tmp = new node;
    tmp->data = data;
    int i = data % 10;

    if(table[i] == nullptr){
        table[i] = tmp;
    }else{
        tmp->next = table[i];
        table[i] = tmp;
    }

}
node *search(int data, node**table){
    int i = abs(data % 10);
    node *tmp = table[i];

    while(tmp != nullptr){
        if (tmp->data == data) return tmp;
        tmp = tmp->next;
    }
    return nullptr;
}

void clear(node **table){
    node *tmp, *tmp2;

    cout << endl << "deletion is reversed. I.e. 32 -- 22 -- 2 means 2 -> 22 -> 32" << endl << endl;
    for (int i = 0; i < t_size; ++i) {
        cout << "table[" << i << "]= ";
        tmp = table[i];

        while(tmp != nullptr){
            cout << tmp->data << " ";
            tmp2 = tmp;
            tmp = tmp->next;
            delete tmp2;
        }
        cout << endl;
    }
    delete []table;
}

int s_chain() {
    int arr[] = {1, 2, 3, 44, 6, 22, 5, 32};
    node **table = create_table();
    for (int i : arr) {
        add(i, table);
    }

    int value;
    node *res;
    cout << "Enter value to search. -1 to stop: ";
    cin >> value;
    while(value != -1){
        res = search(value, table);
        if (res == nullptr){
            std::cout << "Unregisered element" << std::endl;
        }else
            std::cout << "you just got an adress" << endl;
        cin >> value;
    }

    clear(table);
    return 0;
}