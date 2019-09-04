//
// Created by aso on 11/27/18.
//

#include "A.h"
#include <iostream>
#include <stdio.h>
#include <string.h>

using namespace std;



int A_2(char st){
    /* Посчитать слова начинающшиеся на st */

    char str[100];
    int count = 0;

    fgets(str, 100, stdin);

    for(int i=0; str[i] != '0'; i++){
        if ((i==0 || str[i-1] == ' ') && str[i] != ' '){ //начало слова
            if(st == str[i])
                count++;
        }
    }

    return count;
}

void A_1(){
    /* Проверить баланс скобок в строке (кол-во открытых == закрытых) */
    char str[100];
    int round_open = 0, round_close=0, sq_open=0, sq_close=0; // счетчики скобок

    fgets(str, 100, stdin);

    int i = 0;
    bool exit = false;
    while(str[i] != '\0' && !exit) {
        switch (str[i]) {
            case '(': {
                round_open++;
                break;
            }
            case ')': {
                round_close++;
                if (round_close > round_open)
                    exit = true;
                break;
            }
            case '[': {
                sq_open++;
                break;
            }
            case ']': {
                sq_close++;
                if (sq_close > sq_open)
                    exit = true;
                break;
            }
        }i++;
    }

    if (0 == round_open && 0 == round_close && 0 == sq_open && 0 == sq_close){
        cout << "There is 0 brackets" << endl;
    }else if (round_open == round_close && sq_open == sq_close){
        cout << "True!";
    }else{
        cout << "Not true!";
    }
}