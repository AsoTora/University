//
// Created by Андрей on 08/09/2019.
//
#include <iostream>
#include <cstdio>
using namespace std;
struct QuequeItem
{
    int data;
    QuequeItem* next;
};

class Queque
{
private:
    QuequeItem* head;

public:

    void Init()
    {
        head = NULL;
    }

    void Put(int data)
    {
        QuequeItem* element = new QuequeItem();
        element->next = NULL;
        element->data = data;
        if (this->head == NULL)
        {
            head = element;
        }
        else
        {
            QuequeItem* current = head;
            while (current->next != NULL)
            {
                current = current->next;
            }

            current->next = element;
        }
    }

    void Print()
    {
        if (head == NULL)
        {
            return;
        }

        QuequeItem* current = head;
        while (current != NULL)
        {
            cout << current->data << endl;
            current = current->next;
        }
    }
};

int main() {
    Queque queque;
    queque.Init();
    int tmp;
    while (true) {
        cout << "Enter data to put into queque: " << endl;
        cin >> tmp;
        if (tmp = -1){
            return 0;
        }
        queque.Put(tmp);
        cout << "Current queque: " << endl;
        queque.Print();
    }
}