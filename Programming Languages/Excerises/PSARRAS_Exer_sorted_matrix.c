#include <stdio.h>
#include <stdlib.h>

int main()
{
   int i, n=10, j;
   double low=1001.1,high=1201.0, matrix[n],temp;
   double *ptr;
   time_t t;
   srand((unsigned) time(&t));
   
   printf("Matrix:\n");
   for( i = 0 ; i < n ; i++ ) 
   {    	
    	matrix[i]=(low+(float)rand() / (float)(RAND_MAX/(high-low)));
    	printf("%d. %f\n",i+1,matrix[i]);
    	ptr=&matrix[i];
    	printf("%p\n",*ptr);
   }
   for (i=0;i<n;i++)
   {
   	for (j=0;j<n;j++){
   		if (matrix[j]>matrix[i])
		   {
   			temp = matrix[i];    
            matrix[i] = matrix[j];    
            matrix[j] = temp;  			
		   }
	   }
   }
   
   printf("\nSorted Matrix:\n");
   for( i = 0 ; i < n ; i++ ) 
   {    	
    	printf("%d. %f\n",i+1,matrix[i]);
   }
   return(0);
}
