using namespace std;

class Person{
	
	private:
		int age;
		string name;
	public:
		Person(){
		}
		Person(int a, string n){
			age = a;
			name = n;
		}
		void setAge(int a);
		int getAge();
		void setName(string n);
		string getName();
		void printPerson();
};

void Person::setAge(int a){
	age = a;
}

int Person::getAge(){
	return age;
}

void Person::setName(string n){
	name = n;
}

string Person::getName(){
	return name;
}

void Person::printPerson(){
	cout << "Name: " << name << ", " << "Age: " << age << endl;
}
