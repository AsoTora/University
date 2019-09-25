#include <iostream>
#include <cstring>
// TODO: сделать это на python
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

class Shape{
protected:
	int width;		//толщина линий
	string color;		//цвет линий
public:
	void SetWidth(int w);
	void SetColor(string c);
// функция рисования должна переопределяться в производных
// классах
	virtual void Draw();
};

class Dot: private Shape{

};

class Line: private Shape{

};

class Triangle: private Shape{

};

class Rectangle: private Shape{

};

class Ellipse:private Shape{

};

class Point{

};

int main() {
    int c = 0;
    c +=1 == 1;
    std::cout << c;
    return 0;
}