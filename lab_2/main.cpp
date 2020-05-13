#include <iostream>
using namespace std;
int enter(){
    int n;
    cout << "enter:";
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
class array{
private:
    int *arr;	//непосредственно массив
    unsigned size;	//размер массива
public:
    array(){
        size = enter();
        arr = new int[size];
        cout << "Enter elemets: " << endl;
        for (int i = 0; i < size; ++i) {
            cin >> *(arr+i);
        }
    }
    ~array(){delete []arr;}

    void Set(int i, int value){
        this->arr[i-1] = value;
    };
    int Get(int i){        return arr[i-1];
    };
    void Print(){
        for (int i = 0; i < size; i++) {
            cout << *(arr+i);
        }
        cout << endl;
    };

};


int main() {
    auto *arr = new array;
    arr->Print();
    cout << "3: " << arr->Get(3) << endl;
    arr->Set(3, 5);
    cout << "3: " << arr->Get(3) << endl;
    return 0;
}