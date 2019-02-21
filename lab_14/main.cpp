#include <iostream>

using namespace std;

/*
А. Создать двусвязанный список, состоящий из n целых чисел. Выпол-
нить задание. Информационную часть в оперативной памяти не перемещать.
Результат вывести на экран. В конце работы освободить всю динамически
выделенную память

A1. Удалить минимальный элемент очереди.

 ***

B. Выполнить задание в соответствии с вариантом. Информационную
часть в оперативной памяти не перемещать. Результат вывести на экран. В
конце работы освободить всю динамически выделенную память.

B1. Создать двусвязанный список, состоящий из n целых чисел. Из-
влечь из первого списка и переместить во второй список все отрицательные
числа.
*/

// extra
char menu();
int enter();

struct node{
    int data;
    node *next = nullptr;
    node *prev = nullptr;
};

class double_linked_list{
private:
    node *head, *tail;
public:
    double_linked_list(){head = nullptr; tail=nullptr;} // конструктор
    ~double_linked_list() = default; // деструктор

    // adding nodes //
    void append(int);  // в начало
    void add(int);  // в конец
    void insert_after(int);
    void insert_before(int);
    void pop();

    // deleting nodes //
    void clear();
    void del(int);
    void del_node(struct node *);

    // data work //
    void qsort();
    void bubblesort();
    void bubblesort_data();
    void search(int);
    void reverse();

    // show //
    void display();
    void rec_display(node *);
    void taskA();
    void taskB(double_linked_list &);

    // extra //
    bool is_empty(){return head == nullptr;};
    int getsize();
    node *gethead(){return head;};
    node *gettail(){return tail;};
};


// extra
int double_linked_list::getsize(){
    node *tmp = head;
    int c=0;
    while(tmp != nullptr){
        c++;
        tmp = tmp->next;
    }
    return c;
}


// adding nodes
void double_linked_list::add(int value) {
    node *tmp = new node;  // (struct node*)malloc(sizeof(struct node));
    tmp->data = value;

    if (head == nullptr) {
        head = tmp; tail = tmp;
        return;
    }else{
        tmp->next = tail->next;
        tmp->prev = tail;
        tail->next = tmp;
        tail = tmp;
    }
}
void double_linked_list::append(int value){
    node *tmp = new node;  // (struct node*)malloc(sizeof(struct node));
    tmp->data = value;

    if (head == nullptr) {
        head = tmp;
        tail = tmp;
        return;
    }else{
        tmp->next = head;
        tmp->prev = nullptr;
        head->prev = tmp;
        head = tmp;
    }
}
void double_linked_list::insert_after(int value){
    cout << "Enter node to insert after (left -> left, starts with 0): ";
    int pos = enter(), c = 0;

    int size = this->getsize();
    if (pos >= size || pos < 0){
        cout << "Unexpected position" << endl;
        return;
    }else if(pos == size-1){
        this->add(value);
        return;
    }

    node *prev = head, *after;
    node *tmp = new node;
    tmp->data = value;

    while (c != pos){
        c++;
        prev = prev->next;
    }
    after = prev->next;
    prev->next = tmp;
    tmp->prev = prev;
    tmp->next = after;
    after->prev = tmp;
}
void double_linked_list::insert_before(int value){
    cout << "Enter node to insert before (left -> left, starts with 0): ";
    int pos = enter(), c = 0;

    int size = this->getsize();
    if (pos >= size || pos < 0){
        cout << "Unexpected position" << endl;
        return;
    }else if(pos == 0){
        this->append(value);
        return;
    }

    node *curr = head, *prev;
    node *tmp = new node;
    tmp->data = value;

    while (c != pos){
        c++;
        curr = curr->next;
    }
    prev = curr->prev;
    tmp->next = curr;
    tmp->prev = prev;
    curr->prev = tmp;
    prev->next = tmp;
}


// deleting nodes
void double_linked_list::pop(){  // удалить последний элемент очереди
    if (this->is_empty())
        return;
    if (head == tail){
        delete head; head = nullptr; tail = head;
        return;
    }

    node *tmp = tail, *prev = tail->prev;
    prev->next = nullptr;
    tail = tail->prev;
    delete tmp;

}
void double_linked_list::clear(){
    if (this->is_empty()){
        cout << "List is already empty" << endl; return;
    }
    while (head != nullptr){
        node *old = head;
        head = head->prev;
        delete old;
    }

    cout << "List is emptyed" << endl;
}
void double_linked_list::del(int pos){
    int size = this->getsize();
    if (pos >= size || pos < 0){
        cout << "Unexpected position" << endl;
        return;
    }else if(pos == size-1){
        this->pop();
        return;
    }else if(pos == 0){
        node *old = head;
        node *tmp = head->next;
        head = tmp;
        tmp->prev = nullptr;
        delete old;
        return;
    }

    int c = 0;
    node *curr = head, *after, *prev;
    while (c != pos){
        c++;
        curr = curr->next;
    }
    after = curr->next;
    prev = curr->prev;
    prev->next = after;
    after->prev = prev;
    delete curr;
}
void double_linked_list::del_node(struct node *old){
    if (head == nullptr || old == nullptr)
        return;
    else if (head == old)
        head = old->next;

    /* Change next only if node to be deleted is NOT the last node */
    if (old->next != nullptr)
        old->next->prev = old->prev;

    /* Change prev only if node to be deleted is NOT the first node */
    if (old->prev != nullptr)
        old->prev->next = old->next;

    delete old;
}


// data work
void double_linked_list::search(int value) {  // обычный линейный поиск
    int pos=0; node *tmp = head;

    if (this->is_empty()){
        cout << "List is empty.";
    }else{
        while (tmp != nullptr) {
            if (tmp->data == value){
                cout << "Your data is on the " << pos <<"'s position" << endl;
                return;
            }
            tmp = tmp->next; pos++;
        }
        cout << "There is no such data" << endl;
    }
}
void double_linked_list::bubblesort_data() {
    if (this->is_empty() || head == tail) return;
    int size = this->getsize();
    bool swapped = true;

    node *lptr = nullptr;
    while(swapped){
        swapped = false;
        node *ptr1 = head;

        while (ptr1->next != lptr){
            if (ptr1->data > ptr1->next->data){
                swap(ptr1->data, ptr1->next->data);
                swapped = true;
            }
            ptr1 = ptr1->next;
        }
        lptr = ptr1;
    }

}
void double_linked_list::bubblesort() {  // TODO
    if (this->is_empty() || head == tail) return;
    int size = this->getsize();
    bool swapped = true;


    while(swapped){
        swapped = false;
        node *prev = nullptr, *curr = head, *next = curr->next;

        int c = 0;
        while(c < size-1){
            if (curr->data > next->data){
                swapped = true;

                if (prev != nullptr)
                    prev->next = next;

                curr->next = next->next;
                next->prev = curr->prev;
                curr->prev = next;
                next->next = curr;

                prev = next;
                next = curr->next;
            }else{
                prev = curr;
                curr = curr->next;
                next = curr->next;
            }
            c++;
        }size--;
    }
}

// show
void double_linked_list::display(){
    node *tmp = head;
    if (is_empty())
        cout << "List is empty." << endl;
    else{
        cout << "Current double_linked_list: ";
        while(tmp != nullptr){
            cout << tmp->data << " ";
            tmp = tmp->next;
        }
        cout << endl;
    }
}
void double_linked_list::rec_display(node *tmp){
    if(tmp == nullptr){
        cout << "nullptr" << endl;
    }
    else{
        cout << tmp->data << " ";
        rec_display(tmp->next);
    }
}
void double_linked_list::taskA(){
    if (this->is_empty()) return;
    if (head == tail){
        this->pop();
        cout << "Task A.1 successfully completed." << endl;
        return;
    }

    node *tmp = head;
    int min = tmp->data, pos = 0, c = 0;

    while(tmp != nullptr){
        if (tmp->data < min){
            min = tmp->data; pos = c;
        }
        tmp = tmp->next;
        c++;
    }
    this->del(pos);
    cout << "Task A.1 successfully completed." << endl;
}
void double_linked_list::taskB(double_linked_list &lst2){
    if (this->is_empty()){
        cout << "List1 is empty" << endl;
        return;
    }else if (head == tail && head->data < 0){
        lst2.add(head->data); this->pop();
        cout << "Task B.1 successfully completed." << endl;
        return;
    }

    node *tmp = head;
    int d;
    while(tmp != nullptr){
        d = tmp->data;
        if (d < 0){
            lst2.add(d);
            node *old = tmp; tmp = tmp->next;
            this->del_node(old);
        }else{
            tmp = tmp->next;
        }
    }

    cout << "Task B.1 successfully completed." << endl;
}


int main(){
    char choice;
    int data;
    double_linked_list lst;
    double_linked_list lst2; // for task B

    lst.add(-1);
    lst.add(2);
    lst.add(3);
    lst.add(-2);
    lst.display();
    lst.bubblesort();
    lst.display();

    /*
    do{
        choice = menu();
        switch(choice){
            case '1':{
                cout << "Enter value:"; cin >> data;
                lst.push(data); break;
            }
            case '2': lst.pop(); break;
            case '3': {
                cout << "Enter value:"; cin >> data;
                lst.append(data); break;
            }
            case '4': {
                cout << "Enter value:"; cin >> data;
                lst.append(data); break;
            }
            case '5': lst.display(); break;
            case '6': lst.del(); break;
            case '7': lst.clear(); break;
            case '9': {
                cout << "Enter value:"; cin >> data;
                lst.search(data); break;
            }
            case '8': lst.bubblesort(); break;
            case 'r': lst.reverse(); break;
            case 'B': lst.taskB(); lst.display(); break;
            case '0': cout << "exit." << endl; break;
            default: cout << "Wrong choice. Try again." << endl;
        }
    }while(choice != '0');
    */
    return 0;
}
//     cout << "Enter node to delete (left -> left, starts with 0): ";

char menu() {
    char choice;
    cout << endl << endl << "***** Double linked list by aso *****" << endl;
    cout << "1. Add a node to the double_linked_list" << endl;
    cout << "2. Inset after a node in the double_linked_list" << endl;
    cout << "3. Inset before a node in the double_linked_list" << endl;
    cout << "4. Append" << endl;
    cout << "5. Display double_linked_list" << endl;
    cout << "6. Delete a node" << endl;
    cout << "7. Clear double_linked_list" << endl;
    cout << "8. Sort double_linked_list" << endl;
    cout << "9. Search by value" << endl;
    cout << "r. Reverse" << endl;
    cout << "A. Выполнить задание A лабораторной работы:  " << endl;
    cout << "B. Выполнить задание B лабораторной работы:  " << endl;
    cout << "0. Exit" << endl;

    cout << endl << "Choice: ";
    cin >> choice;
    return choice;

}

int enter(){
    int n;

    while(true){
        cin >> n;
        if (!cin){  // == cin.fail()
            cout << "error\n";
            cin.clear();
            while(cin.get()!='\n');
        }else break;
    }
    return n;
}

