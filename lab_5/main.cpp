#include <iostream>
using namespace std;

/*
 * Автомобильный транспорт описывается классом «Автомобиль» (Automobile), который содержит следующую информацию:
 марка автомобиля, тип двигателя (карбюраторный или дизельный), мощность двигателя в л.с., масса автомобиля, пробег в км.

 * «Легковой автомобиль» (Car) производный от «Автомобиля» содержит дополнительную информацию:
расход топлива на 100 км, время разгона до 100 км/ч в секундах, количество пассажирских мест.
 * «Грузовой автомобиль» (Lorry) производный от «Автомобиля» содержит дополнительную информацию:
грузоподъемность в тоннах, тип кузова (открытый или закрытый).
 * «Автобус» (Bus) производный от «Легкового автомобиля» содержит дополнительную информацию:
количество стоячих мест.

 * Необходимо создать парк автомобилей автобазы в виде списка или массива, где каждый элемент представляет собой
указатель на базовый класс Automobile, а указывает на объект производного класса. В базовом классе определить чисто
виртуальную функцию Load(int), которая в производном классе Lorry определяется как загрузка груза, а в классах
Car и Bus – посадка пассажиров. В базовом и производных классах необходимо определить виртуальную функцию Print(),
которая выводит на экран сведения об автотранспорте. Каждый класс должен содержать конструктор с параметрами.
*/

class Auto {
public:
    char* carModel; //модель автомобиля
    char* engineType; //тип двигателя
    int enginePower; //мощность двигателя
    int mass; //масса автомобля
    int mileage; //пробег

    virtual void Load(int) = 0;
    virtual void Print() {
        cout << "Model: " << carModel << endl;
        cout << "Engine: " << engineType << endl;
        cout << "Power: " << enginePower << endl;
        cout << "Mass: " << mass << endl;
        cout << "Mileage: " << mileage << endl;
    }

    Auto() = default;  //по умолчанию
    Auto(char *carModel1, char *engineType1, int enginePower1, int mass1, int mileage1) {
        carModel = carModel1;
        engineType = engineType1;
        enginePower = enginePower1;
        mass = mass1;
        mileage = mileage1;
    }
};


class Car : public Auto { //легковой автомобиль
public:
    int accelerationTime; //время разгона
    int fuelConsumption; //расход топлива
    int passengerSeats; //количество пассажирских мест

    void Load(int) { //посадка пассажиров
        cout << "Посадка!" << endl;
    }
    void Print() {
        cout << "Model: " << carModel << endl;
        cout << "Engine: " << engineType << endl;
        cout << "Power: " << enginePower << endl;
        cout << "Mass: " << mass << endl;
        cout << "Mileage: " << mileage << endl;
        cout << "Acceleration Time: " << accelerationTime << endl;
        cout << "Fuel: " << fuelConsumption << endl;
        cout << "Passenger seats: " << passengerSeats << endl;
    }

    Car() = default;
    Car(char *carModel1, char *engineType1, int enginePower1, int mass1, int mileage1,
        int accelerationTime1, int fuelConsumption1, int passengerSeats1) {
        carModel = carModel1;
        engineType = engineType1;
        enginePower = enginePower1;
        mass = mass1;
        mileage = mileage1;
        accelerationTime = accelerationTime1;
        fuelConsumption = fuelConsumption1;
        passengerSeats = passengerSeats1;
    }
};

class Lory : public Auto { //грузовой автомобиль
public:
    int carryingCapacity; //грузоподъёмность
    char* carcassType; //тип кузова

    void Load(int) { //загрузка груза
        cout << "Load: " << endl;
    }
    void Print() {
        cout << "Model: " << carModel << endl;
        cout << "Engine: " << engineType << endl;
        cout << "Power: " << enginePower << endl;
        cout << "Mass: " << mass << endl;
        cout << "Mileage: " << mileage << endl;
        cout << "Capacity: " << carryingCapacity << endl;
        cout << "Carcass: " << carcassType << endl;
    }

    Lory(char *carModel1, char *engineType1, int enginePower1, int mass1, int mileage1,
         int carryingCapacity1, char *carcassType1) {
        carModel = carModel1;
        engineType = engineType1;
        enginePower = enginePower1;
        mass = mass1;
        mileage = mileage1;
        carryingCapacity = carryingCapacity1;
        carcassType = carcassType1;
    }
};


class Bus : public Car { //автобус
public:
    int standingPlaces;

    void Print() {
        cout << "Model: " << carModel << endl;
        cout << "Engine: " << engineType << endl;
        cout << "Power: " << enginePower << endl;
        cout << "Mass: " << mass << endl;
        cout << "Mileage: " << mileage << endl;
        cout << "Acceleration Time: " << accelerationTime << endl;
        cout << "Fuel: " << fuelConsumption << endl;
        cout << "Passenger seats: " << passengerSeats << endl;
        cout << "Standing seats:  " << standingPlaces << endl;
    }

    Bus(char *, char *, int, int, int, int, int, int, int);
};

Bus::Bus(char *carModel1, char *engineType1, int enginePower1, int mass1, int mileage1,
         int accelerationTime1, int fuelConsumption1, int passengerSeats1, int standingPlaces1) {
    carModel = carModel1;
    engineType = engineType1;
    enginePower = enginePower1;
    mass = mass1;
    mileage = mileage1;
    accelerationTime = accelerationTime1;
    fuelConsumption = fuelConsumption1;
    passengerSeats = passengerSeats1;
    standingPlaces = standingPlaces1;
}

int main(){
    char y, type;
    char* carModel = new char[50];
    char* engineType = new char[50];
    char* carcassType = new char[50];
    int enginePower, mass, mileage, accelerationTime, fuelConsumption, passengerSeats, carryingCapacity, standingPlaces;
//    cout << "Model: "; cin >> carModel;
//    cout << "Engine: "; cin >> engineType;
//    cout << "Power: "; cin >> enginePower;
//    cout << "Mass: "; cin >> mass;
//    cout << "Mileage: "; cin >> mileage;
//    cout << "Acceleration time: "; cin >> accelerationTime;
//    cout << "Fuel: "; cin >> fuelConsumption;
//    cout << "Seats: "; cin >> passengerSeats;

    Car car1("merz", "big", 300, 2000, 300000, 10,
            11, 30);
    car1.Print();

    cout << "***" << endl;

    Bus bus1("merz", "big", 300, 2000, 300000, 10,
            11, 30, 70);
    bus1.Print();
    return 0;
}