#include <iostream>
#include <string.h>
#include <iomanip>

using namespace std;


// Структура, храняющая информацию
struct data{
    int year;
    char city[100];
    data(){ // конструктор
        cout <<"Enter age: ";
        cin >> year;
        cout << "Enter city: ";
        cin >> city;
    }
    ~data() = default;
};

// Узел списка, хранит адрес структуры с датой
struct node{
    data *Student;
    node *next;
    void show();
    ~node(){
        delete Student;
        cout << "Уничтожение данных" << endl;
    };
};

// вывод информации
void node::show(){
    cout << "Student age: " << Student->year << endl;
    cout << "Student city: " << Student->city << endl;
}


// прототипы функций
///
void bsort(node *&head);
void swap(data *&, data *&);
// void list_bsort(node *&head);
// void swap_list(node *&, node *&);
///
void insertFirst(node *&head, node *&last, data *);
void insert(node *&head, node *&last, data*);
///
void remove(node *&head, node *&last);
void deleteall(node *&head);
///
void show(node *);
void showall(node *);
///
char menu();
bool isEmpty(node *head);


int main(){
    node *head = NULL;
    node *last = NULL;
    char choice;

    while(choice != '0'){
        choice = menu();
        switch(choice){
            case '1':{
                data *student = new data; // создание студента
                insert(head, last, student); // привязывание его к структуре
                break;
            }
            case '2': remove(head, last); break;
            case '3': showall(head); break;
            case '4': deleteall(head); break;
            case '5': bsort(head); break;
            case '6': show(head); break;
            case '0': cout << "exit"; break;
            default: cout << "wrong choice! Try again" << endl;
        }
    }
}

/// Insertion ///

void insertFirst(node *&head, node *&last, data *newdata){
    node *temp = new node;
    temp -> Student = newdata;
    temp -> next = NULL;

    head = temp;
    last = temp;
}

void insert(node *&head, node *&last, data *newdata){
    if (isEmpty(head))
        insertFirst(head, last, newdata);
    else{
        node *temp = new node;
        temp -> Student = newdata;

        temp->next = NULL;
        last->next = temp;
        last = temp;
    }
}


/// Deleting ///

void remove(node *&head, node *&last){
    if (isEmpty(head))
        cout << "Already empty";
    else if (head == last){
        delete head->Student;
        delete head;
        head = NULL;
        last = NULL;
    }else{
        node *temp = head;
        head = head-> next;
        delete temp->Student;
        delete temp;
    }
}

void deleteall(node *&head){
    if (isEmpty(head))
        cout << "Already empty";
    else{
        do{
            node * temp = head;
            head = head->next;
            delete temp->Student;
            delete temp;
        }while(head != NULL);
    }
}


/// Output ///

void showall(node *current){
    if (isEmpty(current))
        cout << "Empty list!" << endl;
    else{
        cout << endl << "The list contains:" << endl;
        while (current != NULL){
            current->show();
            cout << "==============" << endl;
            current = current->next;
        }
    }
    cout << endl;
}

void show(node *current){
    if (isEmpty(current)){
        cout << "Empty list!" << endl;
    }else{
        char city[10];
        cout << "Enter city: " << endl;
        cin >> city;
        cout << "The students from the city " << city << "are: " << endl;
        while (current != NULL){
            if(strcmp(current->Student->city, city)==0){
                current->show();
                cout << "==============" << endl;
            }current = current->next;
        }
    }
}


/// Sorting ///

void bsort(node *&head){
    if (!isEmpty(head)){ // если не пустой список
            node *left = head;
            node *right = head->next;

            while(left->next){ // ammount-1
                while(right){ //ammount
                    if(left->Student->year > right->Student->year){
                        swap(left->Student, right->Student);
                    }
                    right = right->next;
                }
                left = left->next; //переход на след элемент
                right = left->next; // вернуть указатель на 1 назад

        }
    }
}

void swap(data *&a, data *&b){
    data *temp = a;
    a = b;
    b = temp;
}


void list_bsort(node *&head){
    if (!isEmpty(head)){ // если не пустой список
        node *curr;
        node *prev ;

        for(bool swapped = true; swapped; ){
            swapped = false;
            prev = head;
            for (curr =head; curr->next != NULL; curr = curr->next){
                if(curr->Student->year > curr->next->Student->year){
                    if(head == curr){
                        head = curr->next;
                        curr->next = head->next;
                        head->next = curr;
                        prev = head;
                    }else{
                        prev->next = curr->next;
                        curr->next = prev->next->next;
                        prev->next->next = curr;
                    }swapped = true;
                }else if (head != curr){
                    prev = prev->next;
                }
            }
        }
    }
}

void swap_list(node *&a, node *&b) {
    node *temp = a;
    a = b;
    b = temp;
}


// дополнительные функции

char menu() {
    char choice;
    cout << "Menu: " << endl;
    cout << "1. Add" << endl;
    cout << "2. Remove" << endl;
    cout << "3. Show" << endl;
    cout << "4. Remove all" << endl;
    cout << "5. Sort all" << endl;
    cout << "6. Show students of entered city: " << endl;
    cout << "0. Exit" << endl;

    cin >> choice;
    return choice;

}

bool isEmpty(node *head){
    if (head == NULL)
        return true;
    else
        return false;
}

/*
int secure_int(){
    int n;

    while(true){
        cin >> n;
        if (cin.fail()){
            cout << "wrong input. Try again\n";
            cin.clear(); while(cin.get()!='\n');
        }else break;
    }
    return n;
}
*/

