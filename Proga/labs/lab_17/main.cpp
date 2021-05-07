#include <iostream>
#include <string>
#include <cstdlib>
#include <cstdio>
#include "Separate Chaining.h"
#include "lin_hash.h"
using namespace std;
const int M = 15; // n
const int t_size = 30; // M

/*
 Хэш-таблица -- спец структура данных для хранение пары ключ-значение. По сути -- ассоциативный массив с хэшированием.
О(1) -- средний, О(n) -- худший случай. Однако в среднем время отклика < бинарных деревьев.
 Хеширование -- класс методов поиска, идея состоит в вычислении хэш-кода, однозначно определяемого хэш-фунцией,
и использование его для поиска

 Коллизии -- столкновения данных.

 Основные методы борьбы(виды таблиц):
1. Метод цепочек (односвязные списки на каждом ключе)
2. Открытая индексация -- пара ключ-значение хранится в таблице
 * */

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
    void add(int key, int data);
    void search(int key);
    void remove(int key);
};

int HashTable::hash(int c) {
    return c*c;
}

void HashTable::add(int key ,int data) {
    int position = key, c=0;
    while(table[position] != nullptr){
        c++;
        position += hash(c);
    }
    auto *tmp = new student;
    tmp->mark = data;
    table[position] = tmp;
}


void HashTable::search(int key) {
    int position = key, c=0;
    if (table[position] == nullptr){
        cout << "empty" << endl;
        return;
    }else{
        cout << table[position]->mark << endl;
    }

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
    t.add(1, 15);
    t.add(3, 12);
    t.add(3, 11);
    t.search(3);

    return 0;
}