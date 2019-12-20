#include <iostream>
#include <climits>
using namespace std;

//математические исключения
class MathException{
    const char* op_name; //имя операции
    long val1; //значение левого операнда операции
    long val2; //значение правого операнда операции
public:
    MathException(const char * name_op, long v1, long v2);
    virtual const char * Message() = 0;
};

MathException::MathException(const char * name_op, long v1, long v2) {
    op_name = name_op;
    val1 = v1;
    val2 = v2;
}

//переполнение сверху
class OverflowException : public MathException {
public:
    OverflowException(const char *name, long a, long b) : MathException(name, a, b) {}
    const char* Message() {
        const char *msg = "Overflow above";
        return msg;
    }
};

//переполнение снизу
class UnderflowException : public MathException {
public:
    UnderflowException(const char *name, long a, long b) : MathException(name, a, b) {}
    const char* Message() {
        const char *msg = "Overflow belove";
        return msg;
    }
};

//деление на 0
class ZdivideException : public MathException {
public:
    ZdivideException(const char *name, long a, long b) : MathException(name, a, b) {}
    const char* Message() {
        const char *msg = "Деление на 0!";
        return msg;
    }
};

class Math{
public:
    long Add(long a, long b){  //(a + b)
        if (a > 0 && b > 0 && a > LONG_MAX - b) throw OverflowException("Add", a, b);
        if (a < 0 && b < 0 && a < LONG_MIN - b) throw UnderflowException("Add", a, b);
        return (a + b);
    }
    long Sub(long a, long b){ //(a - b)
        if (a > 0 && b < 0 && a > LONG_MAX + b) throw OverflowException("Sub", a, b);
        if (a < 0 && b > 0 && a < LONG_MIN + b) throw UnderflowException("Sub", a, b);
        return (a - b);
    }
    long Mul(long a, long b){ //(a * b)
        if (b != 0 && (a > LONG_MAX / b)) throw OverflowException("Multiplie", a, b);
        if (b != 0 && (a < LONG_MIN / b)) throw UnderflowException("Multiplie", a, b);
        return (a * b);
    }
    long Div(long a, long b){ //(a / b)
        if (b == 0) throw ZdivideException("Divide", a, b);
        return (a / b);
    }
    long Mod(long a, long b){ //(a % b)
        if (b == 0) throw ZdivideException("Mod", a, b);
        else if ((a == LONG_MIN) && (b == -1))
            throw OverflowException("Mod", a, b);
        return (a % b);
    }
};

int main(){
    Math test;
    try{
        cout << "Add: " << endl;
        cout << test.Add(LONG_MAX, LONG_MAX) << endl;
        cout << endl;
        cout << "Sub: " << endl;
        cout << test.Sub(LONG_MIN, 10) << endl;
        cout << endl;
        cout << "Multiplie: " << endl;
        cout << test.Mul(LONG_MAX, 2) << endl;
        cout << endl;
        cout << "Divide: " << endl;
        cout << test.Div(47, 0) << endl;
        cout << endl;
        cout << "Mod:" << endl;
        cout << test.Mod(30, 4) << endl;
        cout << endl;
    }
    catch (MathException &ex){
        cout << ex.Message() << endl;;
    }
    return 0;
}

