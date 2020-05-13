#include <iostream>

using namespace std;

template <class T, int size>
class Vector{
protected:
    T vec[size];

public:
    Vector();
    void print();
    friend ostream& operator << (ostream& out, const Vector& vect){
        for (int i = 0; i < size; ++i) {
            out << vect.vec[i] << ' ';
        }
        return out;
    }
    friend istream& operator >> (istream& in, Vector& vect){
        cout << "Enter vector values:" << endl;
        for (int i = 0; i < size; ++i) {
            in >> vect.vec[i];
        }
        return in;
    }
};

template <class T, int size>
Vector<T, size>::Vector() {
    for (int i = 0; i < size; ++i) {
        vec[i] = 0;
    }
}

template <class T, int size>
void Vector<T, size>::print() {
    for (int i = 0; i < size; ++i) {
        cout << vec[i] << " ";
    }
    cout << endl;
}

int main(){
    Vector<char, 3> v1;
    v1.print();
    cin >> v1;
    cout << v1;
    return 0;
}
