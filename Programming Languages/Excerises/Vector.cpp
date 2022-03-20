#include <iostream>
#include <cstring>
#include <cstdlib>
#include <iomanip>
#include <vector>
#include <time.h>
#include <fstream>

using namespace std;

void sort(vector<int>& vect){
	int i,j;
	double temp;
	int n = vect.size();
	double value_a,value_b;
	
	for (i=0;i<n;i++)
   {
   	for (j=0;j<n;j++){
   		if (vect[j]>vect[i])
		   {
   			temp = vect.at(i); 
            vect[i] = vect[j];    
            vect[j] = temp; 			
		   }
	   }
   }
}

void fileout(vector<int>& vect)
{
    int i;
    int n = vect.size();
    ofstream fout("sorted_vector.txt");
    
    for (i = 0; i < n; i++){
    	fout << (i+1) << ". " << vect[i] << "\n";
	}
}

int main(){
	int random_num=100;
	vector<int> vect(random_num);
	time_t t;
    srand((unsigned) time(&t));
	
	while (random_num--){
		vect[random_num]=rand()%1000 + 1;
	}
	
	sort(vect);
	
	fileout(vect);
	
	return 0;
}
