//
// Created by aso on 11/14/18.
//

#include "Extra.h"
#include "iostream"
#include "iomanip"
#include "cmath"

using namespace std;

void E_1(){
    /*
    Заполнить матрицу числами по порядку 1 2 3 4 5 ....как змейка, по часовой стрелке

    Вот пример, чтоб было ясно
     1   2   3   4
    14  15  16   5
    13  20  17   6
    12  19  18   7
    11  10   9   8
    */

    int const n=4;
    int const m=5;

    int Arr[n][m];
    int i=0, j, k = 0, p=1; // p -- первое число

    while (i < n*m){ /*Цикл по номеру витка*/
        k++;
        cout << "a: " << k << endl;

        for (j=k-1; j<m-k+1; j++){
            cout << j << endl;
            Arr[k-1][j] = p++;
            i++;
        }   /*Определение значений верхнего гор столбца*/

        cout << endl << "****" << endl;
        for (j=k; j<n-k+1; j++){
            cout << j << endl;
            Arr[j][m-k]=p++;
            i++;
        }   /* --//-- По правому вертикальному столбцу*/

        cout << endl << "****" << endl;
        for (j=m-k-1; j>=k-1; j--){
            Arr[n-k][j]=p++;
            cout << j << endl;
            i++;
        }   /* --//-- по нижнему горизонтальному столбцу*/
        cout << endl << "****" << endl;
        for (j=n-k-1; j>=k; j--){
            Arr[j][k-1]=p++;
            cout << j << endl;
            i++;
        }   /* --//-- по левому вертикальному столбцу*/

    }

    for (int q=0; q<n; q++){
        for (int w=0; w<m; w++){
            cout << setw(4) << Arr[q][w];
        }

        cout << endl;
    }
}
