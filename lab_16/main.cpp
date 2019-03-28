#include "iostream"
#include "stdio.h"
#include "string.h"
using namespace std;

struct stack{
    double number;
    stack *a;
};

stack *addstack(stack *baka, double);
stack *read(stack *baka, double &);
int priority(char);
void addpostfix(char *stin, char *stout);
int mistake(char *);
double power(double, double);
void enter(char *str, double *mass);
double result(char *strf, double *mass);


stack *addstack(stack *baka, double inf){
    stack *tmp = new stack;
    tmp->number = inf;
    tmp->a = baka;
    return tmp;
}
stack *read(stack *baka, double &inf){
    stack *tmp = baka;
    inf = baka->number;
    baka = baka->a;
    delete tmp;
    return baka;
}
int priority(char s){
    switch (s){
        case '(': case ')': return 0;
        case '+': case '-': return 1;
        case '^': return 3;
        case '/': case '*': return 2;

        default: return -1;
    }
}
void addpostfix(char *stin, char *stout){
    stack *tmp = NULL;
    int n = 0;
    char s;
    double inf;
    for (unsigned int i = 0; i < strlen(stin); i++){
        s = stin[i];
        if (isalpha(s)){
            stout[n++] = s;
            continue;
        }
        if (tmp == NULL || s == '('){
            tmp = addstack(tmp, s);
            continue;
        }
        if (s == ')'){
            while (tmp->number != '('){
                tmp = read(tmp, inf);
                stout[n++] = (char)inf;
            }
            tmp = read(tmp, inf);
            continue;
        }
        int k = priority(s);
        while (tmp != NULL && priority((char)tmp->number) >= k){
            tmp = read(tmp, inf);
            stout[n++] = (char)inf;
        }
        tmp = addstack(tmp, s);
    }
    while (tmp != NULL){
        tmp = read(tmp, inf);
        stout[n++] = (char)inf;
    }
    stout[n++] = '\0';
}
int mistake(char *str){
    stack *pr = NULL;
    double x;
    if (strlen(str) == 1){
        cout << "No expression" << endl;
        cout << '\n';
        return 0;
    }
    if (isalpha(str[0]) || str[0]=='('){ //a^a+b/(a+q)/q
        for (unsigned int i = 0; i < strlen(str); i++){
            if (!isalpha(str[i]) && str[i] != '(' && str[i] != ')' &&  str[i] != '*' && str[i] != '-' && str[i] != '+' && str[i] != '^' && str[i] != '/'){
                cout << "Error" << endl;
                cout << '\n';
                return -1;
            }
            if (str[i] == '('){
                pr = addstack(pr, str[i]);
                continue;
            }
            if(isalpha(str[i]) && str[i+1] == '('){
                cout<<"Error";
                return -1;
            }
            if ((str[i] == '*' || str[i] == '-' || str[i] == '+' || str[i] == '^' || str[i] == '/' || str[i] == '(') && !isalpha(str[i + 1]) && str[i + 1] != '('){
                cout << "Error" << endl;
                cout << '\n';
                return -1;
            }
            if (str[i] == ')'){
                if (isalpha(str[i + 1]) || pr == NULL){
                    cout << "Error" << endl;
                    cout << '\n';
                    return -1;
                }
                x = pr->number;
                pr = pr->a;
                continue;
            }
            if (isalpha(str[i]) && isalpha(str[i + 1])){
                cout << "Error" << endl;
                cout << '\n';
                return -1;
            }
            if (isdigit(str[i])){
                cout << "Error" << endl;
                cout << '\n';
                return -1;
            }
        }
        if (pr != NULL){
            cout << "Error";
            return -1;
        }
    }
    else{
        cout << "Wrong symbol" << endl;
        cout << '\n';
        return -1;
    }
    return 1;
}
double power(double inf1, double inf2){
    double s = 1;
    for (double i = 0; i < inf2; i++)
        s *= inf1;
    return s;
}

double result(char *strf, double *mass){
    stack *tmp = NULL;
    char s;
    double inf, inf1, inf2;
    for (unsigned int i = 0; i < strlen(strf); i++){
        s = strf[i];
        if (isalpha(s)){
            tmp = addstack(tmp, mass[int(s)]);
            continue;
        }
        tmp = read(tmp, inf2);
        tmp = read(tmp, inf1);
        switch (s){
            case '+': tmp = addstack(tmp, inf1 + inf2); break;
            case '-': tmp = addstack(tmp, inf1 - inf2); break;
            case '*': tmp = addstack(tmp, inf1*inf2); break;
            case '/': if (inf2 == 0){
                    cout  << "Error" << endl;
                    cout << '\n';
                    system("pause");
                    return 1;
                }
                tmp = addstack(tmp, inf1 / inf2); break;
            case '^': tmp = addstack(tmp, power(inf1, inf2)); break;
        }
    }
    tmp = read(tmp, inf);
    return inf;
}


void enter(char *str, double *mass){
    double mx[50];
    int n = 0, k = 0;
    for (unsigned int i = 0; i < strlen(str); i++){
        n = 0;
        for (int j = 0; j < k; j++)
            if (mx[j] == int(str[i]))
                n++;
        if (isalpha(str[i]) && mass[int(str[i])] == '\0' && n == 0){
            cout << "Write  " << str[i] << "-->";
            cin >> mass[int(str[i])];
            mx[k++] = int(str[i]);
        }
    }
}

int main(){
    char s;
    char str[100], strf[100];
    double array[50];

    for (int i = 0; i < 26; i++)
        array[i + 97] = 0;
    int k;
    cout << "Write the expression -->" ;
    cin >> str;
    k = mistake(str);
    if (k == 1){
        cout << "Mistakes werent found" << endl;
        enter(str, array);
        addpostfix(str, strf);
        cout << "OPZ: " << str << " -->  " << strf;
        double z = result(strf, array);
        cout << endl << "Result = " << z << endl;
    }
    return 0;
}