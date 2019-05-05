//
// Created by aso on 4/1/19.
//

#include "Hash_class.h"
#include <iostream>
#include <string>
#include<cstdlib>
#include<cstdio>
using namespace std;


int check() {
    int c;
    cin >> c;
    HashMap table;
    while(c != 0){
        table.add(5, 15);
        table.add(3, 23);
        cout << table.search(5);
        table.add(5, 13);
        cout << table.search(5);
        cin >> c;
    }

    return 0;
}