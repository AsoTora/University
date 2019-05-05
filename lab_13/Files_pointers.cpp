// to run in Visual Studio

#include "pch.h"
#include <iostream>
#include <fstream>
#include <stdio.h>
#include <conio.h>
#include <stdlib.h>
#include <string>
#include <io.h>
using namespace std;

struct student
{
    char fio[50];
    int year;
    char birthplace[50];
    int oc1, oc2, oc3;
};

char *name(char[]);
void sozd(char[], FILE *);
void zap(char[], student &, FILE *);
void insertsort(char[], FILE *);
void qsort(char[], FILE *);
void linesearch(char[], FILE *);
void bynarysearch(char[], FILE *);
void vyvod(char[], student &, FILE *);

int main()
{
    FILE *fl = NULL;
    student spisok;
    char im[50];
    name(im);
    sozd(im, fl);
    zap(im, spisok, fl);
    qsort(im, fl);
    insertsort(im, fl);
    linesearch(im, fl);
    bynarysearch(im, fl);
    vyvod(im,spisok, fl);
    system("pause");
    return 0;
}

char * name(char im[])
{
    cout << "Vvedite imya faila" << endl;
    cin >> im;
    return im;
}

void sozd(char im[], FILE *fl)
{
    fopen_s(&fl, name(im), "wb");
    if (fl == NULL) { cout << "Error of creation" << endl; return; }
    fclose(fl);
}

void zap(char im[], student &spisok, FILE *fl)
{
    fopen_s(&fl, im, "wb");
    if (fl == NULL)
    {
        cout << "Open error" << endl; return;
    }
    char ch = 'y';

    do
    {
        cout << "Enter surname" << endl; cin >> spisok.fio;
        cout << "Enter the year" << endl; cin >> spisok.year;
        cout << "Enter birthplace " << endl; cin >> spisok.birthplace;
        cout << "Enter marks " << endl; cin >> spisok.oc1 >> spisok.oc2 >> spisok.oc3;
        fwrite(&spisok, sizeof(student), 1, fl);
        cout << "Anything to add ? (y/n)";
        cin >> ch;
        cout << endl;
    } while (ch == 'y');
    fclose(fl);
}

void vyvod(char im[],student &spisok, FILE *fl)
{
    FILE *ft;
    fopen_s(&ft, "answer.txt", "w");
    if (ft == NULL)
    {
        cout << "Creation error" << endl;
        return;
    }
    fopen_s(&fl, im, "rb");
    if (fl == NULL)
    {
        cout << "Open error" << endl;
        return;
    }
    int n = _filelength(_fileno(fl)) / sizeof(student);
    for (int i = 0; i < n; i++);
    {
        fread(&spisok, sizeof(student), 1, fl);
        if (spisok.oc1 != 2 && spisok.oc2 != 2 && spisok.oc3 != 2)
        {
            cout << spisok.fio;
            fprintf(ft, spisok.fio);
        }
    }
    fclose(ft);
    fclose(fl);
}

void insertsort(char im[], FILE *fl)
{
    FILE *ft;
    fopen_s(&ft, "Insertsort.txt", "w");
    if (ft == NULL) { cout << "Creation error" << endl; return; }
    fopen_s(&fl, im, "rb");
    if (fl == NULL)
    {
        cout << "Reading error" << endl; return;
    }
    int n = _filelength(_fileno(fl));
    student *list = new student[n];
    fread(list, sizeof(student), n,fl);
    student t;
    int i, j;
    for (i = 1; i < n; i++) {
        t = list[i];
        for (j = i - 1; j >= 0 && t.year < list[j].year; j--)
            list[j + 1] = list[j];
        list[j + 1] = t;
    }
    for (int i = 0; i < n; i++)
    {
        cout << list[i].fio << "  " << list[i].year << "  " << list[i].birthplace << "  " << list[i].oc1 << "  " << list[i].oc2 << "  " << list[i].oc3 << endl;
    }
    delete[]list;
    fclose(ft);
    fclose(fl);
}

void qsort(char im[], FILE *fl)
{
    FILE *ft;
    fopen_s(&ft, "QSort.txt", "w");
    if (ft == NULL)
    {
        cout << "Creation error" << endl;
        return;
    }
    fopen_s(&fl, im, "rb");
    if (fl == NULL)
    {
        cout << "Reading error" << endl;
        return;
    }
    int n = _filelength(_fileno(fl)) / sizeof(student);
    student *spisok = new student[n];
    fread(spisok, sizeof(student), n, fl);
    struct
    {
        int l;
        int r;
    } stack[20];
    int i=0, j=n-1, left, right, s = 0;
    student t, x;
    stack[s].l = 0;
    stack[s].r = n - 1;
    while (s != -1)
    {
        left = stack[s].l;
        right = stack[s].r;
        x = spisok[(left + right) / 2];
        while (i <= j)
        {
            while (spisok[i].year < x.year) i++;
            while (spisok[j].year > x.year) j--;
            if (i <= j)
            {
                t = spisok[i];
                spisok[i] = spisok[j];
                spisok[j] = t;
                i++;
                j--;
            }
        }
        if ((j - left) < (right - i))
        {
            if (i < right)
            {
                s++;
                stack[s].l = i;
                stack[s].r = right;
            }
            right = j;
        }
        else
        {
            if (left < j)
            {
                s++;
                stack[s].l = left;
                stack[s].r = j;
            }
            left = i;
        }
    }
    for (int i = 0; i < n; i++)
    {
        cout << spisok[i].fio << "  " << spisok[i].year << "  " << spisok[i].birthplace << "  " << spisok[i].oc1 << "  " << spisok[i].oc2 << "  " << spisok[i].oc3 << endl;
    }
    delete[]spisok;
    fclose(ft);
    fclose(fl);
}

void linesearch(char im[], FILE *fl)
{
    fopen_s(&fl, im, "rb");
    if (fl == NULL)
    {
        cout << "Reading error" << endl;
        return;
    }
    int n = _filelength(_fileno(fl)) / sizeof(student);
    student *spisok = new student[n];
    fread(spisok, sizeof(student), n, fl);
    spisok[n].year = 1991;
    int i = 0;
    while (spisok[i].year != 1991) i++;
    if (i!=n) { cout << (spisok[i].oc1 + spisok[i].oc2 + spisok[i].oc3) / 3 << endl; return; }
    else { cout << "Student not found" << endl; return; }
    fclose(fl);
    delete[]spisok;
}

void bynarysearch(char im[], FILE *fl){
    fopen_s(&fl, im, "rb");
    if (fl == NULL)
    {
        cout << "Reading error" << endl;
        return;
    }
    int n = (_filelength(_fileno(fl)))/sizeof(student);
    student *spisok = new student[n];
    int i = 0, j = n - 1, m;
    while (i < j)
    {
        m = (i + j) / 2;
        if (1991 > spisok[m].year) i = m+1;
        else j = m;
    }
    if (spisok[m].year==1991)
    {
        cout << (spisok[i].oc1 + spisok[i].oc2 + spisok[i].oc3) / 3 << endl; return;
    }
    else { cout << "Student not found" << endl; return; }
    delete[]spisok;
    fclose(fl);
}

