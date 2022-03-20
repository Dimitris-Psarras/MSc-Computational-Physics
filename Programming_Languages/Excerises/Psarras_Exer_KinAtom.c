#include <stdio.h>
#include <string.h>
#include <math.h>

struct atom {
	char Type[2];
	float Mass;
	float Coord[3];
	float Coordvel[3];
}AtomData;

float utot(float ux, float uy, float uz);
float K_energy(float m, float u);

int main(void){
	/*struct atom AtomData;*/
	int counter;
	double total_vel, Kinetic_Energ;
	
	printf("Type of atom: ");
	scanf(" %s",&AtomData.Type);
	
	printf("\nEnter Mass : ");
	
	scanf(" %f",&AtomData.Mass);
	
	printf("\nEnter Coordinates of location and velocity :\n ");
	for(counter=0;counter<3;counter++)
	{
		switch (counter) {
			case 0:
				printf("\nEnter location on x-axis : ");
				scanf("%f",&AtomData.Coord[counter]);
				printf("\nEnter velocity on x-axis : ");
				scanf("%f",&AtomData.Coordvel[counter]);
				break;
			case 1:
				printf("\nEnter location on y-axis : ");
				scanf("%f",&AtomData.Coord[counter]);
				printf("\nEnter velocity on y-axis : ");
				scanf("%f",&AtomData.Coordvel[counter]);
				break;
			case 2:
				printf("\nEnter location on z-axis : ");
				scanf("%f",&AtomData.Coord[counter]);
				printf("\nEnter velocity on z-axis : ");
				scanf("%f",&AtomData.Coordvel[counter]);
				break;
		}
	}
		
	
	total_vel = utot(AtomData.Coordvel[0],AtomData.Coordvel[1],AtomData.Coordvel[2]);;
	
	Kinetic_Energ = K_energy(AtomData.Mass, total_vel);
	printf("\nThe Kinetic Energy of the Atom %s, with mass %.3f kgr, is %f Joule. Its loacation is [%.3f,%.3f,%.3f] and its total velocity is %.4f m/s",AtomData.Type,AtomData.Mass,Kinetic_Energ,AtomData.Coord[0],AtomData.Coord[1],AtomData.Coord[2],total_vel);
}

float utot(float ux, float uy, float uz)
{
	float utotal;
	utotal = sqrt(pow(ux,2)+pow(uy,2)+pow(uz,2));
	return utotal;
}

float K_energy(float m, float u){
	float T;
	T = ((double)1 / (double)2)*m*pow(u,2);
	return T;
}
