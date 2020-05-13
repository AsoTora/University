#include <iostream>
using namespace std;
int enter(){
    int n;

    cout << " enter value: ";
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
 * ЗАМЕЧАНИЯ:
    - Весь ввод/вывод должен осуществляться только внутри функции main().
    - Передача в функции объектов типа класс должна осуществляться через указатель либо ссылку на объект.
    - Все другие нестатические данные должны передаваться функциям через параметры.
    - Все нестатические элементы класса должны иметь закрытый атрибут доступа.
Доступ извне к таким элементам должен осуществляться через функции-элементы класса.

1)	Определите класс Date для хранения даты:
 * Определите функции, которые читают дату из потока ввода, выводят дату. Определите функцию (с параметрами по умолчанию),
которая добавляет день, месяц или год к дате. Определите функцию, которая вычисляет разницу в днях между двумя датами.
 * */


class Date{
private:
    int y; // year
    int m; // month
    int d; // day
public:
    static int objCount;
    Date(int yy, int mm, int dd): y(yy), m(mm), d(dd){
        objCount++;
    }
    Date(Date& dt){ // copy
        this->y = dt.year();
        this->m = dt.month();
        this->d = dt.day();
    }
    ~Date() = default;
    int day(){return d;}
    int year(){return y;}
    int month(){return m;}

    void display(){
        cout << this->year() << '.' << this->month() << '.' << this->day() << endl;
        cout << endl;
    }
    void add_year(int yy = 1){this->y += yy;}
    void add_month(int mm = 1){this->m += mm;}
    void add_day(int dd = 1){this->d += dd;}
};

void add(Date &dt){
    while (true) {
        int c;
        cout << "1: add a year" << endl <<
             "2: add a month" << endl <<
             "3: add a day" << endl <<
             "4: default for year" << endl <<
             "5: default for month" << endl <<
             "6: default for day" << endl <<
             "0: exit" << endl;
        cout << "Enter choice: ";
        cin >> c;
        cout << endl;

        switch (c) {
            case 1: {
                cout << "enter a year: " << endl;
                int yy = enter();
                dt.add_year(yy);
                break;
            }
            case 2: {
                cout << "enter a month" << endl;
                int mm = enter();
                dt.add_month(mm);
                break;
            }
            case 3: {
                cout << "enter a day" << endl;
                int dd = enter();
                dt.add_day(dd);
                break;
            }
            case 4:
                dt.add_year();
                break;
            case 5:
                dt.add_month();
                break;
            case 6:
                dt.add_day();
                break;
            case 0:
                return;
            default:
                cout << "Unexpected value" << endl;
                break;
        }
    }
}

int Date::objCount = 0;

int main() {
    int y = enter();
    int m = enter();
    int d = enter();

    Date date_1(y, m, d);
    Date date_2 = date_1; // copy
    add(date_1);
    date_1.display();
    date_2.display();

    return 0;
}
