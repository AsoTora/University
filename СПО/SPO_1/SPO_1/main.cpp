#include <iostream>
#include "functions.hpp"

using namespace std;

int main(int argc, const char * argv[]) {
    Size size;
    
    try {
        cout << "Enter the size MxN of array" << endl;
        cout << "M: ";
        cin >> size.M;
        

        if (size.M <= 0) {
            throw "M should be > 0";
        }
        
        cout << endl << "N: ";
        cin >> size.N;
        
        if (size.N <= 0) {
            throw "N should be > 0";
        }
        cout << endl;
        
    } catch(const char* msg) {
        cerr << msg << endl;
        return 1;
    }
    
    int *array = createArrayWithSize(size);
    proccessArrayFromPointerWithSize(array, size);
    removeArrayFromPointerWithSize(array, size);
    
    
    return 0;
}
