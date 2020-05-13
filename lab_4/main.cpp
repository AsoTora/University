#include <iostream>
using namespace std;
int enter(){
    int n;

    cout << "enter value: ";
    while(true){
        cin >> n;
        if (!cin){  // == cin.fail()
            cout << "error\n";
            cin.clear();
            while(cin.get()!='\n');
        }else break;
    }
    cout << endl;
    return n;
}
/*
 * ЗАМЕЧАНИЯ:
    - Весь ввод/вывод должен осуществляться только внутри функции main().
    - Передача в функции объектов типа класс должна осуществляться через указатель либо ссылку на объект.
    - Все другие нестатические данные должны передаваться функциям через параметры.
    - Все нестатические элементы класса должны иметь закрытый атрибут доступа.
Доступ извне к таким элементам должен осуществляться через функции-элементы класса.

 1)	Определите в классе Date следующие операции:

Date& operator=(const Date&);//копирование даты
Date& operator+=(const Date&);//добавление даты
Date& operator-=(const Date&);//вычитание даты
Date& operator+=(int);//добавить дни
Date& operator-=(int);//вычесть дни
friend ostream& operator<<(ostream& os, const Date&);//вывод
friend istream& operator>>(ostream& is, Date&);//ввод

*/


class Date{
private:
    int y; // year
    int m; // month
    int d; // day
public:
    Date(int yy=0, int mm=0, int dd=0): y(yy), m(mm), d(dd){
        this->check();
    }
    Date(Date& dt){ // copy
        this->y = dt.year();
        this->m = dt.month();
        this->d = dt.day();
    }
    ~Date() = default;
    int day()const {return d;}
    int year()const {return y;}
    int month()const {return m;}

    void display(){
        cout << this->year() << '.' << this->month() << '.' << this->day() << endl;
    }
    void add_year(int yy = 1){this->y += yy;}
    void add_month(int mm = 1){this->m += mm;}
    void add_day(int dd = 1){this->d += dd;}
    void check(){
        if (d > 30){
            m += d/30;
            d = d%30;
        }
        if (m > 12){
            y += m/12;
            m = m%12;
        }
    }

    Date& operator=(const Date&);//копирование даты
    Date& operator+=(const Date&);//добавление даты
    Date& operator-=(const Date&);//вычитание даты
    Date& operator+=(int);//добавить дни
    Date& operator-=(int);//вычесть дни
    Date& operator++();
    Date operator++(int notused);
    friend ostream& operator<<(ostream& out, const Date&); // вывод
    friend istream& operator>>(istream& in, Date&); // ввод
};

Date& Date::operator=(const Date& dt2){
    this->y = dt2.year();
    this->m = dt2.month();
    this->d = dt2.day();
    return *this;
}

Date& Date::operator+=(const Date& dt2) {
    this->y += dt2.year();
    this->m += dt2.month();
    this->d += dt2.day();
    this->check();
    return *this;
}

Date& Date::operator-=(const Date& dt2) {
    this->y -= dt2.year();
    this->m -= dt2.month();
    this->d -= dt2.day();
    this->check();
    return *this;
}
Date& Date::operator+=(int dd){
    this->d += dd;
    this->check();
    return *this;
}
Date& Date::operator-=(int dd){
    this->d -= dd;
    return *this;
}

Date& Date::operator++(){ // obj++
    this->y++;
    this->m++;
    this->d++;
    this->check();
    return *this;
}
Date Date::operator++(int){ // ++obj
    this->y++;
    this->m++;
    this->d++;
    this->check();
    return *this;
}

ostream& operator<<(ostream& out, const Date& dt){ // ostream& out -- cout
    return out << dt.y << '.' << dt.m << '.' << dt.d << endl;
}
istream& operator>>(istream& in, Date& dt){ // istream& in -- cin
    cout << "Year: "; cin >> dt.y; cout << endl;
    cout << "Month: "; cin >> dt.m; cout << endl;
    cout << "Day: "; cin >> dt.d; cout << endl;

    dt.check();
    return in;
}


int main() {
    int y = enter();
    int m = enter();
    int d = enter();

    Date date_1(y, m, d);
    Date date_2;
    cin >> date_2;

    cout << endl << "******" << endl;
    date_1.display();
    date_2.add_month();
    date_1 = date_2;
    cout << date_1;
    date_2++;
    cout << date_2;

    return 0;
}
