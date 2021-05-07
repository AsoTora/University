//
// Created by aso on 11/15/18.
//

#include "extra.h"
#include "iostream"
#include "cmath"

using namespace std;

int get_size();
void get_arr(double **arr, int);
double get_sum(double **arr, double &, int);

void task(){
    double **arr;
    int N=0;
    double sum=0, pr=1;

    N = get_size();

    // Выделение памяти
    arr = new double *[N]; // Выделение памяти на N строк массива
    for (int i = 0; i < N; i++){
        arr[i] = new double [N];  // Расстягивание каждой строки
    }

    // Заполнение и вывод массива
    get_arr(arr, N);

    // Задача
    sum = get_sum(arr, pr, N);
    cout << endl << "Sum: " << sum << "   " <<  "Proizv: " << pr << endl;


    // Очищение памяти
    for (int i=0; i < N; i++){
        delete[] arr[i];
    }
    delete[] arr;
    arr = nullptr;

}

// Задание
double get_sum(double **arr, double &pr, int N){
    double sum = 0;

    for (int i=0; i<N; i++){
        for (int j=i+1; j<N-i-1; j++){
            if (N-i-1 != i){
                sum += arr[i][j]+arr[N-i-1][j];
                pr *= arr[i][j]*arr[N-i-1][j];
            }
        }
    }
    return sum;
}

int get_size(){
    int N;

    while(true){
        cout << "Enter int size N: " ;
        cin >> N;
        if (!cin){
            cout << "error\n";
            cin.clear();
            while(cin.get()!='\n');
        }else break;
    }
    return N;
}

// Заполнение и вывод массива
void get_arr(double **arr, int N){
    double value=0;

    for(int i=0; i<N; i++){
        for (int j=0; j<N; j++){
            while(true){
                cout << "Enter value: " ;
                cin >> value;
                if (!cin){
                    cout << "Wrong input!\n";
                    cin.clear();
                    while(cin.get()!='\n');
                }else break;
            }
            arr[i][j]=value;
        }
    }

    // Вывод
    cout << endl << "Arr is: ";
    for (int i = 0; i < N; i++) {
        cout << endl;
        for (int j = 0; j < N; j++) {
            cout << " " <<  arr[i][j];
        }
    }
    cout << endl;
}

/*
 * Output
 *
Arr is:
 1 2 3 4 5
 1 2 3 4 5
 1 2 3 4 5
 1 2 3 4 5
 1 2 3 4 5

Sum: 14   Proizv: 72
*/