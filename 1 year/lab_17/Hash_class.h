//
// Created by aso on 4/1/19.
//

#ifndef LAB_17_HASH_CLASS_H
#define LAB_17_HASH_CLASS_H

#include <iostream>
using namespace std;
const int M = 15;
const int t_size = 30;


class student{
public:
    int key;
    int mark;
    student(int key, int mark){
        this->key = key;
        this->mark = mark;
    }
};



class HashMap{
private:
    student **table;
public:
    HashMap(){
        table = new student *[t_size];
        for (int i = 0; i < t_size; ++i) {
            table[i] = nullptr;
        }
    }

    int hash(int key){
        return key % M;
    }

    void add(int key, int mark){
        int pos = hash(key);
        while (table[pos] != nullptr && table[pos]-> key != key){
            pos = hash(pos + 1);
        }
        if (table[pos] != nullptr)
            delete table[pos];
        table[pos] = new student(key, mark);
    }

    int search(int key){
        int pos = hash(key);
        while(table[pos] != nullptr && table[pos]->key != key){
            pos = hash(pos + 1);
        }
        if (table[pos] == nullptr)
            return -1;
        else
            return table[pos]->mark;
    }

    void remove(int key){
        int pos = hash(key);
        while(table[pos] != nullptr){
            if (table[pos]->key == key) break;
            pos = hash(pos+1);
        }
        if (table[pos] == nullptr){
            std::cout << "not found" << std::endl;
            return;
        }else{
            delete table[pos];
        }
        cout << "Element removed;" << endl;
    }

    ~HashMap(){
        for (int i = 0; i < t_size; ++i) {
            if (table[i] != nullptr)
                delete table[i];
        }
        delete []table;
    }
};

int check();
#endif //LAB_17_HASH_CLASS_H
