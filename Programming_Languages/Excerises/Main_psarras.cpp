#include <iostream>

using namespace std;

#include "Person.h"

int main(int argc, char** argv){
	int a = 22;
	string n = "dimitris";
	Person defcon;
	defcon.setAge(a);
	defcon.setName(n);
	defcon.printPerson();
	Person newcon(23,"Dimitris");
	newcon.printPerson();
	return 0;
}
