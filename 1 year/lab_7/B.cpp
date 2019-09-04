//
// Created by aso on 12/13/18.
//

#include "B.h"
#include <stdio.h>
#include <string.h>
#include <iostream>

using namespace std;

void B_1(){
    /* B. Ввести строку с клавиатуры. Выполнить задание, результат вывести
на экран. B1. Вывести на экран порядковый номер слова максимальной длины и
номер позиции в строке, с которой оно начинается. Слова в строке разделены
одним или несколькими пробелами. */

    char str[100];
    int max_len=0, pos=0, por=0, wcount=0; // для вывода ответов
    int temp=0, len; // для решения задачи

    fgets(str, 100 ,stdin);

    for (int i = 0; str[i] != '\0'; i++){

        if ((str[i-1] == ' ' || i == 0) && str[i] != ' '){ // начало слова
            wcount++;
            temp = i; // позиция 1 буквы слова
        }else if (str[i] != ' ' && (str[i+1] == ' ' || str[i+1] == '\0')){ // конец слова
            len = i - temp;
            cout << i;
            cout << temp;
            if (len > max_len){
                max_len = len;
                por = wcount;
                pos = temp;
            }

        }
    }

    cout << "Word poryadok: " << por << endl << "Word start position: " << pos << endl << "Word len: " << max_len << endl;
}


void B_0(){
    /* Вывести на экран самое короткое слово */
    char str[100];
    int min_len=100, temp=0;
    char *start = nullptr;
    fgets(str, 100, stdin);

    for (int i =0; str[i] != '\0'; i++){
        if ((i==0 || str[i-1] == ' ') && str[i] != ' '){  // начало слова
            temp = i;
        }else if (str[i] != ' ' && (str[i+1] == ' ' || str[i+1] == '\0')){  // конец
            if(i-temp < min_len){
                min_len = i-temp;
                start = &str[temp]; // адрес первой буквы слова
            }
        }
    }

    for (int i=0; i < min_len; i++){  // вывод
        cout << "The shortest word: " << *(start+i);
    }
}

void B_00(){
    char str[100];
    double arr[100];
    char temp[101] = "\0";

    int count=-1;
    int len=0;
    char *p = nullptr;
    bool plus = true;

    cout << "enter string of double numbers (with + or -): ";
    fgets(str, 100, stdin);
    strcat(str, " "); // добавить пробел в конце.

    for (int i=0; i <strlen(str)-1; i++){
        if (str[i]== '+' ){
            count++;
            p = &str[i+1];
        }else if(str[i] == '-'){
            plus = false;
            count++;
            p = &str[i+1];        }

        if(str[i+1] != ' '){
            len++;
        }else if (str[i+1] == ' '){
            strncpy(temp, p, len);
            if(plus)
                arr[count] = atof(temp);
            else
                arr[count] = -atof(temp);

            memset(temp, 0, 101); // обнуление данных
            len = 0;
            p = nullptr;
            plus = true;
        }
    }

    // sort
    for(int i=0; i<count; i++){
        for (int j=0; j<count; j++){
            if (arr[j] > arr[j+1]){
                double t = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = t;
            }
        }
    }
    cout << "sorted: ";
    for (int i=0; i<count+1;i++){
        cout << " " << arr[i];
    }
}

void extra(){
    char str[100];
    char str2[100] = "\0";
    int arr[100];
    int k=0, e=0;

    fgets(str, 100, stdin);
    strcat(str, " ");

    for( int i=0; i <strlen(str); i++){
        if (str[i]!= ' '){
            str2[k] = str[i];
            k++;
        }else{
            arr[e] = atoi(str2);
            e++;
            k=0;
            str2[0] = '\0';
        }
    }
    for (int i=0; i<e; i++){
        cout << arr[i];
    }
}

int extra2(){
    // Дана строка, слова разделены одним или несколькими пробелами, вывести слова, содержащие “www”.
    char str[100];
    char *start;
    fgets(str, 100, stdin);
    strcat(str, " ");

    for (int i=0; str[i] != '\0'; i++){
        if (str[i] != ' '){
            start = &str[i];

            while (str[i]!=' '){
                if (str[i] == 'w' && str[i+1] == 'w' && str[i+2] == 'w'){
                    for (int j=0; *(start+j) != ' '; j++){
                        cout << *(start+j);
                    }
                    cout << endl;
                    while(str[i]!=' ') i++;
                }i++;
            }
        }
    }
    return 0;
}

int extra3(){
    // Вывести слова, у которых первый и последний символ одинаковые, а второй и третий разные.
    char str[100];
    char *start;
    fgets(str, 100, stdin);
    strcat(str, "  ");

    for (int i=0; str[i] != '\0'; i++){
        if (str[i] != ' ' && (str[i+1] != str[i+2])){
            start = &str[i];
            while(str[i] != ' '){
                if (str[i] == *start && (str[i+1] == ' ' || str[i+1] == '\n')){
                    for(int j=0; *(start+j) != ' '; j++){
                        cout <<  *(start+j);
                    }
                    cout << endl;
                }i++;
            }

        }
    }
    return 0;
}
