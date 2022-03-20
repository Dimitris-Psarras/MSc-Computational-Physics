#include <stdio.h>
#include <stdlib.h>

int n=10;

void sort(double *matrixold[n]);

int main()
{
   int i, j;
   double low=2.1,high=3.4, matrix[n],temp;
   double *ptr, *matrixptr[n];
   time_t t;
   srand((unsigned) time(&t));
   
   printf("Matrix:\n");
   for( i = 0 ; i < n ; i++ ) 
   {    	
    	matrix[i]=(low+(float)rand() / (float)(RAND_MAX/(high-low)));
    	printf("%d. %f\n",i,matrix[i]);
    	ptr=&matrix[i];
    	matrixptr[i]=ptr;
   }
   sort(matrixptr);
   printf("\nSorted Matrix:\n");
   for( i = 0 ; i < n ; i++ ) 
   {    	
    	printf("%d. %f\n",i,matrix[i]);
   }
   return(0);
}

void sort(double *matrixold[n])
{
	int i,j;
	double temp;
	double *ptr,*ptre;
	for (i=0;i<n;i++)
   {
   	for (j=0;j<n;j++){
   		ptr=matrixold[j];
   		ptre=matrixold[i];
   		if (*ptr>*ptre)
		   {
   			temp = *ptre;    
            *ptre = *ptr;    
            *ptr = temp; 			
		   }
	   }
   }
}
