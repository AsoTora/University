#include <iostream>
#include <cmath>

using std::cout;
using std::cin;
using std::endl;

int extra(){
    /* Расположить в обратном порядке эл-ты массива который стоит между первым и последним нулевыми эл-тами в основном массиве */
    int SIZE;
    int *z_1 = nullptr; // empty pointer
    int *z_2 = nullptr; // empty pointer

    cout << "Enter size: ";
    cin >> SIZE;
    cout << endl;

    int *arr = new int[SIZE];
    for (int i = 0; i < SIZE; i++) {
        cout << "Enter value of " << i << " element: " ;
        cin >> arr[i];
    }

    // Вывод старого массива + получение адрессов нулевых эл-тов
    cout << endl << "Old arr is: ";
    for (int i = 0; i < SIZE; i++) {
        cout << " " << arr[i];

        if (arr[i] == 0 && z_1 == nullptr) {
            z_1 = &arr[i];  // <==> int *z_1 = arr + i; // адрес 1-го эл-та, который будет == 0
        }
        if (arr[i] == 0 && z_1 != nullptr) {
            z_2 = &arr[i]; // адрес последнего нуля
        }
    }

    // Проверка на то, что в массиве точно 2 нуля. Если нет -- завершение выполнения функции.
    if (z_1 == z_2 ) {
        cout << endl << "Array is the same!";
        return 1;
    }
    if (z_2 == nullptr) {
        cout << endl << "There is only 1 zero!";
        return 1;
    }
    else{
        cout << endl << "*******" << endl; // else
        while (z_1 + 1 <= z_1 + (z_2 - z_1) / 2) { // z_2 - z_1  == длина полученного подмассива
            int temp = *(z_1 + 1);
            *(z_1 + 1) = *(z_2 - 1);
            *(z_2 - 1) = temp;

            z_1++;
            z_2--;
        }
    }

    // Вывод нового массива
    cout << "New arr is: ";
    for (int i = 0; i < SIZE; i++)
        cout << " " << arr[i];


    delete[] arr;
    return 0;
}


int main() {
    extra();
    return 0;
}