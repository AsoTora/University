#include "functions.hpp"
#include <iostream>
#include <stdio.h>
#include <stdlib.h>

using namespace std;

int* createArray(Size size) {
    int *array = (int *)malloc(size.M * size.N * sizeof(int));

    cout << "enter array values:" << endl;
    for (int i = 0; i < size.M; i++) {
        for (int j = 0; j < size.N; j++) {
            cout << "arr[" << i << "][" << j << "]: ";
            cin >> array[i * size.N + j];
            cout << endl;
        }
    }
    
    return array;
}

void find_min_max(int *array, Size size) {
    int min = array[0];
    int max = array[0];
    
    for (int i = 0; i < size.M; i++) {
        for (int j = 0; j < size.N; j++) {
            if (array[i * size.N + j] < min) {
                min = array[i * size.N + j];
            }
            
            if (array[i * size.N + j] > max) {
                max = array[i * size.N + j];
            }
        }
    }
    
    cout << "max: " << max << endl;
    cout << "min: " << min << endl;
}

void removeArray(int *array, Size size) {
    free(array);
}

int enter(){
    int n;

    while(true){
        cin >> n;
        if (!cin){  // == cin.fail()
            cout << "error. Try again\n";
            cin.clear();
            while(cin.get()!='\n');
        }else break;
    }
    return n;
}