#include <iostream>
#include <string>
#include "Separate Chaining.h"
#include "lin_hash.h"
using namespace std;
const int M = 15;

struct student{
    string surname;
    int group;
    int mark;
};

int main() {
    s_chain();
    return 0;
}