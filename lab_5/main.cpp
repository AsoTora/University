#include <iostream>
#include <cstring>
#include <cmath>
using namespace std;
/*
 * 1) Реализуйте простую графическую систему с использованием графических средств Win32 API. Абстрактный класс
    Является общим интерфейсом для классов Dot (точка), Line (линия), Triangle (треугольник), Rectangle (прямоугольник),
 Ellipse (эллипс). Line задается парой объектов Point, который не является производным от Shape, Triangle задается
 тройкой (массивом) объектов Point. Предусмотреть возможность установки для всех фигур толщины и цвета линии,
 цвета заливки. Shape невидим до вызова функции Draw().
 *
 *
 */

enum colors {black, white, green};
void get_color(enum colors color){
    switch (color){
        case black:{
            cout << "Im black." << endl;
        }
        case white:{
            cout << "Im white" << endl;
        }
        case green:{
            cout << "Im green" << endl;
        }
    }
}

class Shape{
protected:
	int width; // толщина линий
	enum colors color; // цвет линий
public:
	void SetWidth(int w){
	    this->width = w;
	};
	void SetColor(enum colors c){
	    this->color = c;
	};
	virtual void Draw(); //  должна переопределяться в производных классах
	~Shape() = default;
};

class Dot: private Shape{
protected:
    int x, y;
public:
    Dot (int w, enum colors color, int xx, int yy): x(xx), y(yy){
        SetColor(color);
        SetWidth(w);
    }
    void Draw(){
        cout << "This is an dot. Coordinates: [" << x << "," << y << "]." << endl;
        cout << "Width is " << width << endl;
        get_color(color);
    }
    int getx(){ return x; }
    int gety(){ return y; }
    ~Dot() = default;
};

class Line: private Shape{
protected:
    int length;
    int x1, x2;
    int y1, y2;
public:
    Line(int w, enum colors color, int xx1, int yy1, int xx2, int yy2):x1(xx1), x2(xx2), y2(yy2), y1(yy1){
        int wid, col;
        cout << "Enter dot1 width: "; cin >> wid; cout << endl;
        cout << "Enter dot1 color (1 -- black, 2 -- white, 3 -- green): "; cin >> col; cout << endl;
        Dot d1(wid, static_cast<colors>(col), x1, y1);

        cout << "Enter dot2 width: "; cin >> wid; cout << endl;
        cout << "Enter dot2 color (1 -- black, 2 -- white, 3 -- green): "; cin >> col; cout << endl;
        Dot d2(wid, static_cast<colors>(col), x2, y2);

        SetWidth(w); // for Shape Class
        SetColor(color);
    }
    Line (int w, enum colors color, Dot d1, Dot d2){ // diff constructor
        SetWidth(w); // for Shape Class
        SetColor(color);
        x1 = d1.getx(); x2 = d2.getx();
        y1 = d1.gety(); y2 = d2.gety();
    }
    void Draw(){
        cout << "This is an line. Coordinates: [" << x1 << "," << y1 << ";" << x2 << ',' << y2 << "]." << endl;
        cout << "Width is " << width << endl;
        get_color(color);
    }
    ~Line() = default;
};

class Triangle: private Shape{
protected:
    int x1, x2, x3;
    int y1, y2, y3;
public:
    Triangle (int w, enum colors color, Dot *d1, Dot *d2, Dot *d3){
        SetWidth(w); // for Shape Class
        SetColor(color);
        x1 = d1->getx(); x2 = d2->getx(); x3 = d3->getx();
        y1 = d1->gety(); y2 = d2->gety(); y3 = d3->gety();
    }
    void Draw(){
        cout << "This is an Triangle. Coordinates: [" << x1 << "," << y1 << ";" << x2 << ','
            << y2 << ";" << x3 << "," << y3 << "]." << endl;
        cout << "Width is " << width << endl;
        get_color(color);
    }
    ~Triangle() = default;
};

class Rectangle: private Shape{

};

class Ellipse:private Shape{

};

int main() {
    Dot d1(1, black, 1,2), d2(2, white,3,4), d3(3, green, 5,6);
    d1.Draw();
    Line line1(2, black, d1, d2);
    line1.Draw();
    return 0;
}