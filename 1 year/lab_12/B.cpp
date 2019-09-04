//
// Created by aso on 2/5/19.
//

#include "B.h"
#include <iostream>
#include <fstream>
#include <string>

/*
Дополнить программу, написанную при выполнении лабораторной ра-
боты No10 функциями поиска элементов по ключу в массиве структур. Найти
элемент с заданным ключом указанным методом поиска (для упрощения пред-
полагается, что в массиве присутствует не более одного такого элемента).
Если элемент не найден, то вывести соответствующее сообщение.
*/

/*
 Технически, поиск был написан при вчполнении лаб работы 9 для функции удаления записи,
но поиск идет по порядковому номеру таковой, введеному пользователем (см. delete_rec)
*/

using namespace std;

// extra functions
int enter();
void choose_db(string &);
void add_arr(const string &);
void delete_rec(string &);
void sortmerge(const string &);
void sortquick(const string &);
void search(const string &);

// Data
struct contact{
    char name[10];
    int age;  // ключ для функций сортировки
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
    int get_age (){ return cnt.age; };
};

// public class methods
void DtbRec::getdata(){ // get user input
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
int Bmain() {
    DtbRec xRec{};
    fstream file;  // объект класса fstream
    char ch;  // for the menu
    int num; // для функций
    const int size = sizeof(DtbRec);  // чтобы каждый раз не вызывать sizeof()
    string path = "/home/aso/CLionProjects/lab_12/database.dtb";
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
             << endl << "8.Sort file via QuickSort. Key -- contacts age."
             << endl << "9.Sort file via MergeSort. Key -- contacts age."
             << endl << "f.Press f to ̶p̶a̶y̶ ̶r̶e̶s̶p̶e̶c̶t find record by a key."
             << endl << "q.Exit"
             << endl << endl << "Enter Choice: ";
        cin >> ch;
        cout << endl;

        // Да, я знаю, что лучше было использовать switch и разбить все на функции//
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
                cout << endl << "Record No[" << num << "]";
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

    // We reach here when element is not present in array
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
        }else if(ch == '8'){
            sortquick(path);
        }else if(ch == '9'){
            sortmerge(path);
        }else if (ch == 'f'){
            search(path);
        }
    } while(ch != 'q');

    remove(path.c_str());
    cout << "Thank you for using us!";
    return 0;
}

// extra
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

void choose_db(string &str){
    char ch;
    cout << "Current database file -- " << str
         << "\nPress 'c' to change. Any key to continue: ";
    cin >> ch;
    if (ch == 'c'){
        cout << "Choose the database file! Enter path: ";
        cin >> str;
        cout << endl;
    }
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


// Quick sort
int partition(DtbRec *arr, int l, int r){
    int p = arr[r].get_age();
    int index = l;

    for (int j = l; j < r; j++){
        if (arr[j].get_age() <= p){
            swap(arr[j], arr[index]);
            index++;
        }
    }
    swap(arr[index], arr[r]); // поставить базовый эл-т на свое место (слева от него все <)
    return index;
}

void quicksort(DtbRec *arr, int left, int right) {
    if (left < right){
        int p = partition(arr, left, right);
        quicksort(arr, left, p-1); // before pivot
        quicksort(arr, p+1, right); // after pivot
    }
}

void sortquick(const string &path){
    fstream file;
    DtbRec xRec;
    DtbRec *arr = nullptr;
    int ammount=0;
    file.open(path, ios::in|ios::binary);

    if(file.is_open()){
        // Так как мне лень учить <vector>, мне нужно знать размер массива,
        // т.е. кол-во классов в файле. Один из способов это сделать -- математически посчитать
        file.seekg(0, ios::end);
        int fl_sz = static_cast<int>(file.tellg());
        file.seekg(0, ios::beg);
        ammount = fl_sz/sizeof(DtbRec); // количество записей

        arr = new DtbRec[ammount]; // массив записей
        for(int i=0; file.read((char*)&xRec, sizeof(DtbRec)); i++){
            arr[i] = xRec;
        }
    }else{
        cout << "Error";
    }
    file.close();

    if (arr == nullptr) // чтобы не сортировать неоткрытый файл
        return;

    quicksort(arr, 0, ammount-1);
    file.open(path, ios::out|ios::binary);
    if(file.is_open()){
        file.write((char*)arr, ammount*sizeof(DtbRec));  // записать массив
        cout << "*** Database is sorted via QuickSort! ***";
    }else{
        cout << "Error";
    }

    file.close();
    delete []arr;
}


// Merge sort
void merge(DtbRec arr[], int l, int m, int r){
    int n1 = m - l + 1; // индекс 1
    int n2 =  r - m; // индекс 2 (для подмассивов)

    DtbRec L[n1], R[n2]; // temp arrays

    for (int i = 0; i < n1; i++) // arr[l..m]
        L[i] = arr[l + i];
    for (int j = 0; j < n2; j++) // arr[m+1..r]
        R[j] = arr[m + 1+ j];

    int i = 0;
    int j = 0;
    int k = l;
    while (i < n1 && j < n2) {
        if (L[i].get_age() <= R[j].get_age()) {
            arr[k] = L[i];
            i++;
        } else{
            arr[k] = R[j];
            j++;
        }
        k++;
    }

    while (i < n1) {
        arr[k] = L[i];
        i++;
        k++;
    }

    while (j < n2) {
        arr[k] = R[j];
        j++;
        k++;
    }
}

void mergesort(DtbRec arr[], int left, int right){
    if (left < right){
        int m = (left+right)/2;
        mergesort(arr, left, m);
        mergesort(arr, m+1, right);

        merge(arr, left, m, right); // объединить
    }
}

void sortmerge(const string &path){
    fstream file;
    DtbRec xRec;
    DtbRec *arr = nullptr;
    int ammount=0;
    file.open(path, ios::in|ios::binary);

    if(file.is_open()){
        file.seekg(0, ios::end);
        int fl_sz = static_cast<int>(file.tellg());
        file.seekg(0, ios::beg);
        ammount = fl_sz/sizeof(DtbRec); // количество записей

        arr = new DtbRec[ammount]; // массив записей
        for(int i=0; file.read((char*)&xRec, sizeof(DtbRec)); i++){
            arr[i] = xRec;
        }
    }else{
        cout << "Error";
    }
    file.close();

    if (arr == nullptr) // чтобы не сортировать неоткрытый файл
        return;

    mergesort(arr, 0, ammount-1);
    cout << "*** Database is sorted via MergeSort! ***";
    file.open(path, ios::out|ios::binary);
    if(file.is_open()){
        file.write((char*)arr, ammount*sizeof(DtbRec));  // записать массив

    }else{
        cout << "Error";
    }

    file.close();
    delete []arr;
}


// Searching
void search(const string &path){
    // Тот же принцип. Достать все записи в буфер и поиск по ним. Немного сокрачу расход памяти,
    //сделав чисто массив с тем же порядком.
    fstream file;
    DtbRec xRec;
    int *arr = nullptr;
    int ammount=0;
    file.open(path, ios::in|ios::binary);

    if(file.is_open()){
        file.seekg(0, ios::end);
        int fl_sz = static_cast<int>(file.tellg());
        file.seekg(0, ios::beg);
        ammount = fl_sz/sizeof(DtbRec); // количество записей

        arr = new int[ammount]; // массив записей
        for(int i=0; file.read((char*)&xRec, sizeof(DtbRec)); i++){
            arr[i] = xRec.get_age(); // сохраню чисто возраст
        }
    }else{
        cout << "Error";
    }
    file.close();

    if (arr == nullptr)
        return;


    char ch;
    int key;
    cout << "Enter key(age): ";
    cin >> key;
    cout << "Choose searchmethod 1 -- binary, 2 -- linear: ";
    cin >> ch;
    switch(ch){
        case '1':{ // binary search
            int left=0, right=ammount-1, m;
            bool found = false;
            while(left < right){
                m = (right+left)/2;
                if (key < arr[m])
                    right = m-1;
                else if (key > arr[m])
                    left = m+1;
                else
                    cout << "Your contacts number in DB is " << m << endl; found=true; break;
            }
            if (!found)
                cout << "There is no contact with this age." << endl;
        } break;

        case '2':{  // linear search
            int last = arr[ammount-1];
            arr[ammount-1] = key;
            int i=0;
            while(arr[i] != key) i++;
            arr[ammount-1] = last;
            if (i != ammount-1 || last == key)
                cout << "Your contacts number in DB is " << i << endl;
            else cout << "There is no contact with this age." << endl;
        } break;

        default: cout << "wrong choice" << endl;
    }

    delete []arr;
}