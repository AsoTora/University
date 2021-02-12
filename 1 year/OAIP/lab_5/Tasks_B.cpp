//
// Created by aso on 10/17/18.
//

#include <iostream>
#include <iomanip>
#include "Tasks_B.h"

using namespace std;

int B_1(){
    /* B. Ввести с клавиатуры количество строк и столбцов массива, выде-
лить необходимый объем памяти для хранения элементов массива и ввести ис-
ходные данные. Выполнить задание, результат вывести на экран.

B1. Задана матрица размером N×M. Поменять местами строку, содержа-
щую элемент с максимальным значением, со строкой, содержащей элемент с
минимальным значем */

    int N = 0, M = 0; // строки, стобцы
    int max = 0, min = 0;
    int *max_adress = nullptr, *min_adress = nullptr;
    int **arr;

    cout << "Enter N, M: ";
    cin >> N >> M;
    cout << endl;

    arr = new int *[N]; // Выделение памяти на N строк массива
    for (int i = 0; i < N; i++){
        arr[i] = new int [M];  // Расстягивание каждой строки
    }

    // Заполнение массива
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < M; j++) {
            cout << "Enter [" << i << "][" << j << "] value: ";
            cin >> arr[i][j];
        }
    }

    // Вывод старого массива
    cout << endl << "Old arr: ";
    for (int i = 0; i < N; i++) {
        cout << endl;
        for (int j = 0; j < M; j++) {
            cout << " " <<  arr[i][j];
        }
    }

    // Нахождение максимального и минимального эл-та, нахождение адресов строк с ними
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < M; j++) {
            if (arr[i][j] > max){
                max = arr[i][j];
                max_adress = arr[i]; // адрес строки c максим. эл-том == указатель на ее первый элемент
            }
            if (arr[i][j] < min) {
                min = arr[i][j];
                min_adress = arr[i];  // адрес строки с мин. эл-том == указатель на ее первый элемент
            }
        }
    }

    // Замена строк местами
    if (max_adress != min_adress){
        for (int i = 0; i < M; i++){
            int temp =  max_adress[i];
            max_adress[i] = min_adress[i];
            min_adress[i] = temp;
        }
    }else{ // максимальный и минимальный элемент в одной строке
        cout << endl << "Max and Min elements are in the same string!" << endl;
        return 1;
    }

    // Вывод нового массива
    cout << endl << "New arr: ";
    for (int i = 0; i < N; i++) {
        cout << endl;
        for (int j = 0; j < M; j++) {
            cout << " " <<  arr[i][j];
        }
    }


    // Очищение памяти
    for (int i=0; i < N; i++){
        delete[] arr[i];
    }
    delete[] arr;

    return 0;
}

int B_2(){
    /*. Задана матрица размером N×M. Упорядочить ее столбцы по возраста-
нию их наименьших элементов.*/

    int N = 0, M = 0; // строки, стобцы
    int **arr, *b, min;

    N = 3;
    M = 4;
    b = new int [M]; // выделение памяти на временный массив

    // Выделение памяти
    arr = new int *[N]; // Выделение памяти на N строк массива
    for (int i = 0; i < N; i++){
        arr[i] = new int [M];  // Расстягивание каждой строки
    }

    // Заполнение массива
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < M; j++) {
            cout << "Enter [" << i << "][" << j << "] value: ";
            cin >> arr[i][j];
        }
    }

    // Вывод старого массива
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < M; j++) {
            cout << setw(3) << arr[i][j];
        }
        cout << endl;
    }
    cout << "*****" << endl;


    // поиск минимальных элементов в столбцах
    for (int j = 0; j < M; j++){  // создание временного массива для хранения
        b[j] = arr[0][j]; // мин эл-т -- 1 элемент столбца
        for (int i =0; i < N; i++){
            if (arr[i][j] < b[j])
                b[j] = arr[i][j];
        }
    }

    // зная минимальный эл-т, методом пузырьковой сортировки сортировать стобцы, сравнивая и от первого
    for (int i = 0; i < M-1; i++){ // каждый раз минимальный эл-т становится на 0 место, потом на 1 и т.д.
        min = i; // для сортировки

        for (int j = i+1; j < M; j++){
            if (b[j] < b[min])
                min = j;
        }

        for (int j = 0; j < N; j++){ // меняем столбец с минимальным эл-том с 0-вым, потом следующий мин с 1-м и т.д.
            int tmp = arr[j][i];
            arr[j][i]=arr[j][min];
            arr[j][min]=tmp;
        }

        int tmp = b[i]; // та же сортировка для матрицы с минимальными эл-тами
        b[i] = b[min];
        b[min] = tmp;

    }

    // Вывод нового массива
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < M; j++) {
            cout << setw(3) << arr[i][j];
       }
       cout << endl;
    }

    // Освобождение памяти
    for(int i=0; i < N; i++)
        delete [ ]arr[i];
    delete [ ]arr;
    arr = nullptr;

    delete []b;
    return 0;
}

int B_15(){
    /*B15. Задана матрица размером N×M. Упорядочить ее строки по убыванию
их максимальных элементов.*/


}