#include <iostream>
#include <cstdlib>
#include <time.h>

using namespace std;

class Particle{
	private:
		int position;
	public:
		Particle() {position = 0;}	
		int getP();
		void right();
		void left();
};

class Experiment{
	private:
		Particle particle;
		int steps;
	public:
		Experiment(int ns) {steps = ns;}
		int run();
};


int Particle::getP() {
	return position;
}

void Particle::right() {
	position = position + 1;
}

void Particle::left() {
	position = position - 1;
}

int Experiment::run(){
	int i;
	double ran;
	time_t t;
    srand((unsigned) time(&t));
	for ( i = 0 ; i <steps ; i++ ){
		ran = (double)rand() / (double)RAND_MAX;
		if (ran>0.5){
			particle.right();
		}
		else{
			particle.left();
		}
	}
	return particle.getP();
}

int main(int argc, char** argv){
	int i,fp, array_steps[]={10,100,1000,10000,100000};
	int len = sizeof array_steps / sizeof *array_steps;
	for ( i = 0 ; i < len ; i++ ){
		Particle p;
		Experiment sim(array_steps[i]);
		fp = sim.run();
		printf("Steps = %d: Final Position = %d\n",array_steps[i], fp);
	}
	return 0;
}
