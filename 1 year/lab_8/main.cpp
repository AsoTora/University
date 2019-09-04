#include <iostream>
#include <cstring>
#include <cstdio>
#include <cstdlib>
using namespace std;

// моя структура
struct students
{
    char name[50], place[50];
    int m1, m2, m3;
};

int main() {
    int n;
    cout << " enter the number of students: ";
    cin >> n;
    students *list = new students[n];

    for (int i = 0; i < n; i++) {
        cout << " Name of student: ";
        cin >> list[i].name;
        cout << " Place of birth: ";
        cin >> list[i].place;
        cout << " First mark: ";
        cin >> list[i].m1;
        cout << " Second mark: ";
        cin >> list[i].m2;
        cout << " Third mark: ";
        cin >> list[i].m3;
        cout << endl;
    }

    int *gpa = new int[n];
    students tmp;

    for (int i = 0; i < n - 1; i++) {
        if (strcmp(list[i].place, "Минск") == 0) {
            for (int j = i + 1; j < n; j++) {
                gpa[i] = list[i].m1 + list[i].m2 + list[i].m3;
                gpa[j] = list[j].m1 + list[j].m2 + list[j].m3;
                if (gpa[i] < gpa[j]) {
                    tmp = list[i];
                    list[i] = list[j];
                    list[j] = tmp;
                }
            }
        }
    }

    for (int i = 0; i < n; i++){
        if (strcmp(list[i].place, "Минск")==0)
            cout << list[i].name << " " << list[i].place << endl;
    }

    delete [] gpa;
    delete [] list;
    return 0;
}