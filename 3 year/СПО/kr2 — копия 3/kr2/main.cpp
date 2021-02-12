//
//  main.cpp
//  kr2
//
//  Created by Vasil' on 11/7/20.
//

#include <thread>
#include <iostream>
#include <fstream>
#include <mutex>
#include <condition_variable>

using namespace std;

static const int MAX_COUNT = 5;

struct Date {
    int year;
    int month;
    int day;
};

struct Dates {
    int count = 0; //количество имеющихся элементов в массиве
    Date dates[100];
} dts = {0};

mutex kLock;
condition_variable kCv;
bool kReady = false;
bool kProcessed = false;

void secondThread(Dates* dates){
    ofstream datesFile("dates.txt");

    int currentCount = dates->count;
    
    while (currentCount < MAX_COUNT) {
        // дождаться передачи управления от главного потока
        {
            unique_lock<std::mutex> lk(kLock);
            kCv.wait(lk, [] { return kReady; } );
        }
        
        if (dates->count != currentCount) {
            currentCount = dates->count;
            Date date = dates->dates[currentCount-1];
            datesFile << "date[" << currentCount << "]: { day: " << date.day << ", month: " << date.month << ", year: " << date.year << " } \n" << endl;
        }
        
        {
            std::lock_guard<std::mutex> lk(kLock);
            kProcessed = true;
            kCv.notify_one();
        }
    }
    
    datesFile.close();
}

int main(int argc, const char * argv[]) {
    thread secondThr(secondThread, &dts);
    secondThr.detach();
    
    while (dts.count < MAX_COUNT) {
        Date tmp;
        
        cout << "Enter year: ";
        cin >> tmp.year;
        cout << endl << "Enter month: ";
        cin >> tmp.month;
        cout << endl << "Enter day: ";
        cin >> tmp.day;
        cout << endl;
        
        dts.dates[dts.count] = tmp;
        dts.count++;
        
        {
            // передать управление второму потоку
            std::lock_guard<std::mutex> lk(kLock);
            kReady = true;
            kCv.notify_one();
        }
        
        // дождаться выполнения второго потока
        std::unique_lock<std::mutex> lk(kLock);
        kCv.wait(lk, []{return kProcessed;});
    }
    
    return 0;
}
