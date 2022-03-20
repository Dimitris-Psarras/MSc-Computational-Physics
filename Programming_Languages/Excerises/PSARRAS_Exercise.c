#include <stdio.h>
#include <stdlib.h>
#define NR_END 1
#define FREE_ARG char*

double *mvector;
void nrerror(char error_text[]);
double *ivector(long nl, long nh);
void free_dvector(double *v, long nl, long nh);

int main()
{
	int svector;
	printf("Enter the size of the vector: ");
    scanf("%d", &svector); 
    mvector=ivector(1,svector);
    printf("\n");
    
	int i, n=10, j;
	double low=1.1,high=15.5, temp;
   	time_t t;
   	srand((unsigned) time(&t));
   	
   	printf("Vector:\n");
   	for( i = 0 ; i < svector ; i++ ) 
   	{
	    mvector[i]=(low+(float)rand() / (float)(RAND_MAX/(high-low)));
   	 	printf("%d. %f\n",i+1,mvector[i]);
   	}
   	for (i=0;i<svector;i++)
   	{
   	for (j=0;j<svector;j++){
   		if (mvector[j]>mvector[i])
		   {
   			temp = mvector[i];    
            mvector[i] = mvector[j];    
            mvector[j] = temp;  			
		   }
	   }
   	}
   	printf("\nSorted Vector:\n");
   	for( i = 0 ; i < svector ; i++ ) 
   	{    	
		printf("%d. %f\n",i+1,mvector[i]);
   	}
   	
   	free_dvector(mvector,1,svector);
   	return(0);
}

void nrerror(char error_text[])
/* Numerical Recipes standard error handler */
{
	fprintf(stderr,"Numerical Recipes run-time error...\n");
	fprintf(stderr,"%s\n",error_text);
	fprintf(stderr,"...now exiting to system...\n");
	exit(1);
}

double *ivector(long nl, long nh)
/* allocate an int vector with subscript range v[nl..nh] */
{
	double *v;

	v=(double *)malloc((size_t) ((nh-nl+1+NR_END)*sizeof(double)));
	if (!v) nrerror("allocation failure in ivector()");
	return v-nl+NR_END;
}

void free_dvector(double *v, long nl, long nh)
/* free a double vector allocated with dvector() */
{
	free((FREE_ARG) (v+nl-NR_END));
}
