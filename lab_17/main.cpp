#include <iostream>
#include <string>
#include<cstdlib>
#include<cstdio>
#include "Separate Chaining.h"
#include "lin_hash.h"
using namespace std;
const int M = 15; // n
const int t_size = 30; // M

/*
 * Объявить и ввести массив структур из n элементов. Создать хеш-таблицу из М элементов. Осуществить поиск элемента по ключу в хеш-таблице.
Вывести на экран исходный массив, хеш-таблицу и все поля найденной структуры. Задание выбрать в соответствии с номером варианта в табл. V.
 */

struct student{
    int mark;
    // string name;
};

class HashTable{
private:
    student **table;
public:
    HashTable(){ // создание массива структур
        table = new student*[t_size];
        for (int i = 0; i < t_size; ++i) {
            table[i] = nullptr;
        }
    }
    ~HashTable(){ // его удаление
        for (int i = 0; i < t_size; ++i) {
            if (table[i] != nullptr)
                delete table[i];
        }delete []table;
    }

    int hash(int c);
    void add(int data);
    void search_key(int key);
    int search_data(int data);
    void remove(int key);
};

int HashTable::hash(int c) {
    return c*c;
}

void HashTable::add(int data) {
    int position = 0, c=0;
    while(table[position] != nullptr){
        c++;
        position += hash(c);
    }
    auto *tmp = new student;
    tmp->mark = data;
    table[position] = tmp;
}

void HashTable::search_key(int key) {
    if (table[key] != nullptr){
        cout << table[key]->mark << endl;
        return;
    }
    cout << "empty" << endl;
}

int HashTable::search_data(int data) {
    for (int i = 0; i < t_size; ++i) {
        if (table[i] != nullptr && table[i]->mark == data)
            return i;
    }
    return -1;
}

void HashTable::remove(int key){
    if (table[key] == nullptr){
        cout << "not found" << endl;
        return;
    }else{
        delete table[key];
    }
    cout << "Element removed;" << endl;
}



int main() {
    HashTable t;
    t.add(15);
    t.add(12);

    return 0;
}