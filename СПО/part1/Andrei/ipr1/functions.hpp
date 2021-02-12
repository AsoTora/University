#ifndef functions_hpp
#define functions_hpp

struct Size {
    int M;
    int N;
};


int* createArray(Size size);
void find_min_max(int *array, Size size);
void removeArray(int *array, Size size);
int enter();

#endif /* functions_hpp */
