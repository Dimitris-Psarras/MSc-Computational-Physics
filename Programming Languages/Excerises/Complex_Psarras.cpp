# include <iostream>
using namespace std;

class Complex{
	private:
		double real;
		double imag;
	public:
		Complex(double r=0, double i=0) {real = r; imag = i;}		
	friend Complex operator+(Complex v,Complex w);
	friend Complex operator-(Complex v, Complex w);
	friend Complex operator*(Complex v, Complex w);
	friend ostream& operator<<(ostream& o, Complex& v);
};

Complex operator+(Complex v,Complex w){
	Complex result(v.real + w.real,v.imag + w.imag);
	return result;
}

Complex operator-(Complex v, Complex w){
	Complex result(v.real-w.real,v.imag-w.imag);
	return result;
}

Complex operator*(Complex v, Complex w){
	Complex result(v.real*w.real-v.imag*w.imag, v.imag*w.real+v.real*w.imag);
	return result;
}

ostream& operator<<(ostream& o, Complex& v){
	o << "(" << v.real << ")" << "+ i" << "(" << v.imag << ")" <<endl;
	return o;
}

int main(int argc, char**argv){
	int integer = 5;
	Complex z1(2,1), z2(3,2);
	cout << "Print the given complex numbers:"<< endl;
	cout << z1 << z2;
	cout << "Print the addition of the two given complex numbers:";
	Complex z3;
	z3 = z1 + z2;
	cout << z3;
	cout << "Print the subtraction of the two given complex numbers:";
	Complex z4;
	z4 = z1 - z2;
	cout << z4;
	cout << "Print the multiplication of the two given complex numbers:";
	Complex z5;
	z5 = z1 * z2;
	cout << z5;
	cout << "Print the addition of the first given complex number and the integer " << integer << ":";
	Complex z6;
	z6 = z1 + integer;
	cout << z6;
	cout << "Print the addition of an integer " << integer << " and the second given complex number:";
	Complex z7;
	z7 = integer + z2;
	cout << z7;
	return 0;
}
