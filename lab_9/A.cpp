//
// Created by aso on 1/27/19.
//

#include "A.h"
#include <iostream>
#include <fstream>
#include <string>
#include <stdio.h>

using namespace std;

void A_1() {
    int count=0, sum=0;
    string path = "/home/aso/CLionProjects/lab_9/info.txt";
    string path1 = "/home/aso/CLionProjects/lab_9/res.txt";

    ofstream fout; // write
    fout.open("/home/aso/CLionProjects/lab_9/info.txt", ifstream::out);
    if (!fout.is_open()){
        cout << "Error!" << endl;
    }else{
        for (int i = 0; i < 10; i++) {
            cout << "enter " << i << " number: ";
            int a;
            cin >> a;
            fout << a << '\n';
        }
    }
    fout.close();

    ifstream file;
    ofstream results;

    file.open(path);
    results.open(path1);


    if(!file.is_open()){
        cout << "Error!" << endl;
    }else{
        cout << "Opened" << endl;

        while(!file.eof()){
            int i=0;
            file >> i;

            if (i < 0) count++;
            if (i%2 == 0) sum += i;
        }
    }

    results << "Summa: " << sum << '\n';
    results << "Ammount: " << count;

    cout << "Summa: " << sum << endl;
    cout << "Ammount: " << count << endl;

    file.close();
    results.close();
}

void A_1_1(){
    const char *path = "/home/aso/CLionProjects/lab_9/info.dat";
    string path1 = "/home/aso/CLionProjects/lab_9/res.dat";

    FILE *f = fopen(path, "wb");
    if (f==NULL){
        cout << "Error" << endl;
    }else{

    }

    fclose(f);
}