#include <iostream>
#include "functions.hpp"

using namespace std;



int main(int argc, const char * argv[]) {
    Size size{};
    
    try {
        cout << "Enter the size of an array MxN " << endl;
        cout << "M: ";
        size.M = enter();

        if (size.M <= 0) {
            throw "M should be > 0";
        }
        
        cout << endl << "N: ";
        size.N = enter();
        
        if (size.N <= 0) {
            throw "N should be > 0";
        }
        cout << endl;
        
    } catch(const char* msg) { // catch errors
        cerr << msg << endl;
        return 1;
    }
    
    int *array = createArray(size);
    find_min_max(array, size);
    removeArray(array, size);
    
    return 0;
}
