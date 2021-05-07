#ifndef functions_hpp
#define functions_hpp

struct Size {
    int M;
    int N;
};


int* createArrayWithSize(Size size);
void proccessArrayFromPointerWithSize(int *array, Size size);
void removeArrayFromPointerWithSize(int *array, Size size);

#endif /* functions_hpp */
