//
// Created by aso on 1/28/19.
//

#include "B.h"
#include <iostream>
#include <fstream>
#include <string>
#include <stdio.h>

using namespace std;

// extra functions
int enter();
string choose_db(string &);
void add_arr(const string &);
void delete_rec(string &);

// class instance structures
struct  contact{
    char name[10];
    int age;
};

struct address{
    char city[10];
    char country[10];
};

// main data unit
class DtbRec{
private:
    contact cnt;
    address adr;
public:
    void getdata();
    void dispdata();
};

// public class methods
void DtbRec::getdata(){ //get user input
    cout << "Enter contacts name: ";
    cin >> cnt.name;
    cout << "Enter contacts age: ";
    cnt.age = enter();
    cout << "Enter adress country: ";
    cin >> adr.country;
    cout << "Enter adress city: ";
    cin >> adr.city;

}
void DtbRec::dispdata(){  //display to screen
    cout << endl << "Contacts name: " << cnt.name << endl;
    cout << "Contacts age: " << cnt.age << endl;
    cout << "Adress country: " << adr.country << endl;
    cout << "Adress city: " << adr.city << endl;
}


// main
int func() {
    DtbRec xRec{};
    fstream file;  // объект класса fstream
    char ch;  // for the menu
    int num; // для функций
    const int size = sizeof(DtbRec);  // чтобы каждый раз не вызывать sizeof()
    string path = "/home/aso/CLionProjects/lab_9/database.dtb";
    choose_db(path);

    do {
        cout << endl << endl << "Fstream DataBase menu"
             << endl << "1.Add records"
             << endl << "2.View records"
             << endl << "3.Modify records"
             << endl << "4.Delete database file (clear all database.)"
             << endl << "5.Change database file"
             << endl << "6.Add multiple records"
             << endl << "7.Delete a single record"
             << endl << "q.Exit"
             << endl << endl << "Enter Choice: ";
        cin >> ch;
        cout << endl;

        if (ch == '1') { // add data
            file.open(path, ios::out | ios::binary | ios::app); // app for just appending without seeking
            // file.seekp(0,ios::end); // sets the file write pointer to the end of a file

            xRec.getdata();
            file.write((char *) &xRec, size);

            file.close();
        } else if (ch == '2') { // show data
            file.open(path, ios::in | ios::binary);
            file.seekg(0,ios::beg);

            num = 0;
            while (file.read((char *) &xRec,size)) { // !file.eof() -- не подойдет, т.к. у нас глобальная временная перменная xRec
                cout << endl << "Recorjustd No[" << num << "]";
                xRec.dispdata();
                num++;
            };

            file.close();
        } else if (ch == '3') { // edit data;
            file.open(path, ios::in | ios::out | ios::binary);

            cout << "Enter the record no(starts at 0): ";
            cin >> num;

            // получить размер файла на данный момент
            file.seekg(0, ios::end);
            int fl_sz = static_cast<int>(file.tellg());
            file.seekg(0, ios::beg);
            // вообще, можно было бы и глобально запоминать, сколько всего записей есть

            if (fl_sz >= num * size) {
                file.seekg(num * size, ios::beg);  // move the read pointer
                file.read((char *) &xRec, size);

                cout << "*** Here is the old info ***";
                xRec.dispdata();
                cout << endl << "*** Type new one *** " << endl;
                xRec.getdata();

                // cin.clear();
                file.seekp(num * size, ios::beg);  // move the write pointer
                file.write((char *) &xRec, size);
            } else {
                cout << "You are trying to modify unexisted records! ";
            }

            file.close();
        }else if(ch == '4'){
            if(remove(path.c_str()) != 0) // path.c_str() приведет string path к char *
                cout << "Error deleting file!";
            else
                puts( "Database file successfully deleted." );
        }else if(ch == '5'){
            choose_db(path);
        }else if (ch == '6'){
            add_arr(path);
        }else if(ch == '7'){
            delete_rec(path);
        }
    } while(ch != 'q');

    remove(path.c_str());
    cout << "Thank you for using us!";
    return 0;
}

int enter(){
    int n;

    while(true){
        cin >> n;
        if (!cin){  // == cin.fail()
            cout << "error\n";
            cin.clear();
            while(cin.get()!='\n');
            cout << "Try again: ";
        }else break;
    }
    return n;
}

string choose_db(string &str){
    char ch;
    cout << "Current database file -- " << str
    << "\nPress 1 to change. Any key to continue: ";
    cin >> ch;
    if (ch == '1'){
        cout << "Choose the database file! Enter path: ";
        getline(cin, str, '\n'); // cin >> path;
        cout << endl;
    }
    return str;
}

void add_arr(const string &path){
    fstream file;
    file.open(path, ios::out|ios::binary);

    int s;
    cout << "Enter ammount of records: ";
    cin >> s;

    auto *arr = new DtbRec[s]; // создание массива указателей на объекты класса
    for (int i = 0; i < s; i++) {
        arr[i].getdata();
        cout << endl;
    }

    file.write((char*)arr, s* sizeof(DtbRec));

    delete[] arr;
    file.close();
}

void delete_rec(string &path){
    string temppath = "/home/aso/CLionProjects/lab_9/tempdatabase.dtb";
    fstream tempfile, file;
    bool b = false;
    int num, size = sizeof(DtbRec);
    DtbRec xRec;

    tempfile.open(temppath, ios::out|ios::binary);
    file.open(path, ios::in|ios::out|ios::binary);

    cout << "Enter the record no(starts at 0): ";
    cin >> num;

    // получить размер файла на данный момент
    file.seekg(0, ios::end);
    int fl_sz = static_cast<int>(file.tellg());
    file.seekg(0, ios::beg);

    if (fl_sz >= num*size){
        file.seekp(0, ios::beg);
        int rec = -1; // Так как я удаляю объект не по полю, сделаю это по его порядковому номеру в БД
        while(file.read((char *)&xRec, size)){
            rec++;
            if(rec != num){
                tempfile.write((char *)&xRec, size);
            }else{
                b = true; // нашли нашу запись
            }
        }
    }else{
        cout << "The record doesnt exist";
    }

    file.close();
    tempfile.close();
    if (b){  // поменять местами основной и временный файл. Удалить основной
        remove(path.c_str());
        rename(temppath.c_str(), path.c_str());
    }
}

