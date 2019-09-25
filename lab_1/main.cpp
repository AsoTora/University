#include <iostream>
using namespace std;

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
/*
 * Определите функции, которые читают дату из потока ввода, выводят дату. Определите функцию (с параметрами по умолчанию),
которая добавляет день, месяц или год к дате. Определите функцию, которая вычисляет разницу в днях между двумя датами.
 * */


class Date{
private:
    unsigned int y; // year
    unsigned int m; // month
    unsigned int d; // day
public:
    Date(){
        cout << " Enter year: "; y = enter();
        cout << "Enter month: "; m = enter();
        cout << "Enter day: "; d = enter();
        cout << endl;
    }
    ~Date() = default;
    void display(){
        cout << y << '.' << m << '.' << d << endl;
        cout << endl;
    }
    void change(){
        while (true) {
            int c;
            cout << "1: change a year" << endl <<
                 "2: change a month" << endl <<
                 "3: change a day" << endl <<
                 "0: exit" << endl;
            cout << "Enter choice: ";
            cin >> c;

            switch (c){
                case 1:
                    cout << "enter a year" << endl;
                    this->y = enter();
                    break;
                case 2:
                    cout << "enter a month" << endl;
                    this->m = enter();
                    break;
                case 3:
                    cout << "enter a day" << endl;
                    this->d = enter();
                    break;
                case 0:
                    return;
                default:
                    cout << "Unexpected value" << endl;
                    break;
            }
        }
    }

    unsigned int getday(){
        return this->d;
    }
};

unsigned int diff(Date first, Date second){
    return first.getday() - second.getday();
};

int main() {
    struct Date today;
    struct Date random;
    //today.display();
    //today.change();
    //today.display();

    unsigned int d = diff(today, random);
    if (d < 0) {
        cout << "ooops" << endl;
    }else{
        cout << d;
    }
    return 0;
}

