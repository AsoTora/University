#include <iostream>
#include <math.h>
#include <stdio.h>
#include <string.h>
using namespace std;
struct stack
{
    double inf;
    stack *next;
};

stack *AddStack(stack* sp, double inf)
{
    stack* spt = new stack;
    spt->inf = inf;
    spt->next = sp;
    return spt;
}

stack *ReadStack(stack* sp, double &inf)	// Ïðî÷òåíèå ñ óäàëåíèåì
{
    stack *spt = sp;
    inf = spt->inf;
    sp = sp->next;
    delete spt;
    return sp;
}

int priority(char ch)	// Âû÷èñëåíèå ïðèîðèòåòà îïåðàöèè
{
    switch (ch)
    {
        case '(': case ')': return 0;
        case '+': case '-': return 1;
        case '*': case '/': return 2;
        case '^': return 3;
        default: return -1;
    }
}

void AddPostFix(char *strin, char *strout)
{
    stack *sp = NULL;
    int n = 0;
    char ch;
    double inf;
    for (unsigned int i = 0; i < strlen(strin); i++)
    {
        ch = strin[i];
        if (ch == '^')
        {
            int pr = priority(ch);
            while (sp != NULL && priority((char)sp->inf) >= pr)
            {
                sp = ReadStack(sp, inf);
                strout[n++] = (char)inf;
            }
            sp = AddStack(sp, ch);
            continue;
        }
        // Åñëè ýòî îïåðàíä
        if (ch >= 'A')
        {
            strout[n++] = ch;
            continue;
        }
        // Åñëè ñòåê ïóñò èëè íàéäåíà îòêðûâàþùàÿ ñêîáêà
        if (sp == NULL || ch == '(')
        {
            sp = AddStack(sp, ch);
            continue;
        }
        // Åñëè íàéäåíà çàêðûâàþùàÿ ñêîáêà
        if (ch == ')')
        {
            while (sp->inf != '(')
            {
                sp = ReadStack(sp, inf);
                strout[n++] = (char)inf;
            }
            sp = ReadStack(sp, inf); // Óäàëåíèå îòêðûâàþùåé ñêîáêè
            continue;
        }
        // Åñëè îïåðàöèÿ
        int pr = priority(ch);
        while (sp != NULL && priority((char)sp->inf) >= pr)
        {
            sp = ReadStack(sp, inf);
            strout[n++] = (char)inf;
        }
        sp = AddStack(sp, ch);
    }
    while (sp != NULL)
    {
        sp = ReadStack(sp, inf);
        strout[n++] = (char)inf;
    }
    strout[n++] = '\0';
}

double rasAV(char *str, double *mz)
{
    stack *sp = NULL;
    char ch;
    double inf, inf1, inf2;
    for (unsigned int i = 0; i < strlen(str); i++)
    {
        ch = str[i];
        // Åñëè íàéäåí îïåðàíä
        if (ch >= 'A' && ch != '^')
        {
            sp = AddStack(sp, mz[int(ch)]);
            continue;
        }
        // Åñëè íàéäåí çíàê îïåðàöèè
        sp = ReadStack(sp, inf2);
        sp = ReadStack(sp, inf1);
        if (ch == '/' && inf2 == 0)
        {
            cout << endl << "Деление на ноль!";
            return -1;
        }
        switch (ch)
        {
            case '+': sp = AddStack(sp, inf1 + inf2); break;
            case '-': sp = AddStack(sp, inf1 - inf2); break;
            case '*': sp = AddStack(sp, inf1 * inf2); break;
            case '/': sp = AddStack(sp, inf1 / inf2); break;
            case '^': sp = AddStack(sp, pow(inf1, inf2)); break;
        }
    }
    sp = ReadStack(sp, inf);
    return inf;
}

int main()
{
    double masz[122];
    char str[100], strp[100], strArguments[100];
    cout << "Ввод выражения: "; cin >> str;
    int i = 1;
    int arg = 0;
    bool b = true;
    if (str[0] == '*' || str[0] == '/' || str[0] == '^') {
        b = false;
    }
    else if (str[strlen(str) - 1] == '+' || str[strlen(str) - 1] == '-' || str[strlen(str) - 1] == '*' || str[strlen(str) - 1] == '/' || str[strlen(str) - 1] == '^') {
        b = false;
    }
    else {
        int counter1 = 0, counter2 = 0;
        if (str[0] == '(') counter1++;
        else if (str[0] == ')') b = false;
        if (str[0] >= 'a' && str[0] <= 'z') {
            strArguments[arg] = str[0];
            arg++;
        }
        if ((str[0] < 'a' || str[0] > 'z') && str[0] != '(') {
            b = false;
        }
        if (b) {
            for (i; i < strlen(str); i++) {
                if ((str[i] < 'a' || str[i] > 'z') && str[i] != '(' && str[i] != ')' && str[i] != '+' && str[i] != '-' && str[i] != '*' && str[i] != '/' && str[i] != '^') {
                    b = false;
                    break;
                }
                if (str[i] == '0' && str[i - 1] == '/') {
                    b = false;
                    break;
                }
                if (str[i] >= 'a' && str[i] <= 'z' && str[i - 1] >= 'a' && str[i - 1] <= 'z') {
                    b = false;
                    break;
                }
                if ((str[i] == '+' || str[i] == '-' || str[i] == '*' || str[i] == '/' || str[i] == '^') && (str[i - 1] == '+' || str[i - 1] == '-' || str[i - 1] == '*' || str[i - 1] == '/' || str[i - 1] == '^')) {
                    b = false;
                    break;
                }
                if (str[i] == '(') counter1++;
                if (str[i] == ')') counter2++;
                if (counter2 > counter1) {
                    b = false;
                    break;
                }
                if ((str[i] == '+' || str[i] == '-' || str[i] == '*' || str[i] == '/' || str[i] == '^') && str[i - 1] == '(') {
                    b = false;
                    break;
                }
                if (str[i] == ')' && (str[i - 1] == '+' || str[i - 1] == '-' || str[i - 1] == '*' || str[i - 1] == '/' || str[i - 1] == '^')) {
                    b = false;
                    break;
                }
                if (str[i] == ')' && (str[i - 1] < 'a' || str[i - 1] > 'z')) {
                    b = false;
                    break;
                }
                if (str[i-1] == ')' && (str[i] >= 'a' && str[i] <= 'z')) {
                    b = false;
                    break;
                }
                if (str[i] >= 'a' && str[i] <= 'z') {
                    strArguments[arg] = str[i];
                    arg++;
                }
            }
            if (b) {
                if (str[strlen(str) - 1] == '(') {
                    b = false;
                }
                else if (counter1 != counter2) b = false;
            }
        }
    }
    if (b) {
        cout << endl;
        for (int j = 0; j < arg; j++) {
            cout << "сука";
            cout << strArguments[j] << " ";
            /*
            if (masz[int(strArguments[j])] < 0) {
                cout << "Ввод значения переменной" << strArguments[j] << ": ";
                cin >> masz[int(strArguments[j])];
            }*/
        }
        AddPostFix(str, strp);
        cout << endl << strp;
        double s = rasAV(strp, masz);
        cout << endl << "Result: " << s << endl;
        return 0;
    }
    else {
        cout << "Ошибка выражения!!" << endl;
        return 0;
    }
}
