#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

#define threads_number 16

double f(double x){
	// Function to be integrated
	return x*exp(2*x);
}

int main(void){
	
	
	int N = 100000001;
	if(N%2 == 0){
		printf("Error: Number of points must be odd! Exiting...\n");
		return 0;
	}	
	
	int i, x_min = 0, x_max = 3;
	double segment, odd_sum = 0, even_sum = 0;
	segment = (double) (x_max-x_min)/(N-1);
	
	double start_time = omp_get_wtime();
	
	#pragma omp parallel num_threads(threads_number) shared(x_min,x_max,segment,N) private(i) reduction(+:odd_sum,even_sum)
	{
		int myid = omp_get_thread_num();
		int nThreads = omp_get_num_threads();
		
		int iStart = myid*N/nThreads;
		int iEnd = (myid+1)*N/nThreads;
		
		if(myid == 0){
			iStart=1;
		} 
		if(myid == nThreads-1){
			iEnd = N-1;
		}
		
		for (i=iStart ; i < iEnd ; i++){
			if (i%2 == 0 && i < N-2){
				even_sum += f(i*segment);
			}
			else{
				odd_sum += f(i*segment);
			}
		}
	}

	double end_time = omp_get_wtime();
	
	double I = (segment/((double)3))*(f(x_min)+4*odd_sum+2*even_sum+f(x_max));
	printf("I = %lf\n",I);
	
	printf("Time = %f\n",end_time-start_time);
	
	
	return 0;
}
