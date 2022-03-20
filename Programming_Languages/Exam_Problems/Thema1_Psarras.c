#include <stdio.h>
#include <stddef.h>
#include <stdlib.h>
#define NR_END 1
#define FREE_ARG char*

double **MNmatrix;
void nrerror(char error_text[]);
double **dmatrix(long nrl, long nrh, long ncl, long nch);
void free_dmatrix(double **m, long nrl, long nrh, long ncl, long nch);
void mergesort(double arr[],int low, int middle, int high);
void sort(double array[], int min, int max);
double** random(double **MNmatrix, int r, int c);

int main(void){
	int M = 3, N = 4;
	MNmatrix = dmatrix(0,M-1,0,N-1);
	
	int i,j;
	double array[M],min_array[N];
    
    MNmatrix = random(MNmatrix, M, N);
	
	for( i = 0 ; i < N ; i++ ) 
   	{
   		for ( j = 0 ; j < M ; j++)
		{
			array[j] = MNmatrix[j][i];
		}
		sort(array,0,M-1);
		for ( j = 0 ; j < M ; j++)
		{
   			MNmatrix[j][i] = array[j];
		}
   	}
   	
   	printf("\n\nSorted Matrix:");
   	for( i = 0 ; i < M ; i++ ) 
   	{
   		printf("\nRow %d: ",i);
   		for ( j = 0 ; j < N ; j++)
		{
   	 		printf(" %f   ",MNmatrix[i][j]);	
		}
   	}
   	
   	printf("\n\nUnsorted row on minimum values of each column from the sorted Matrix:\n");
   	for( i = 0 ; i < N ; i++ ) 
   	{
   		min_array[i] = MNmatrix[0][i];
   		printf("%d. %f   ",i+1,min_array[i]);
   	}
   	sort(min_array,0,N-1);
	
	printf("\n\nSorted row on minimum values of each column from the sorted Matrix:\n");
    for( i = 0 ; i < N ; i++ ) 
    {    	
    	printf("%d. %f   ",i+1,min_array[i]);
    }
   
	printf("\n\nThe maximum value form the minimum array is : max = %f\n", min_array[N-1]);
	
	free_dmatrix(MNmatrix,0,M-1,0,N-1);
	
	return 0;
}






double** random(double **MNmatrix, int r, int c){
	int i,j;
	double low=1001.1,high=1201.0;
    time_t t;
    srand((unsigned) time(&t));
    
    printf("Matrix:");
   	for( i = 0 ; i < r ; i++ ) 
   	{
   		printf("\nRow %d: ",i);
   		for ( j = 0 ; j < c ; j++)
		{
   			MNmatrix[i][j]=(low+(double)rand() / (double)(RAND_MAX/(high-low)));
   	 		printf(" %f   ",MNmatrix[i][j]);	
		}
   	}
	return MNmatrix;
}

void nrerror(char error_text[])
/* Numerical Recipes standard error handler */
{
	fprintf(stderr,"Numerical Recipes run-time error...\n");
	fprintf(stderr,"%s\n",error_text);
	fprintf(stderr,"...now exiting to system...\n");
	exit(1);
}

double **dmatrix(long nrl, long nrh, long ncl, long nch)
/* allocate a double matrix with subscript range m[nrl..nrh][ncl..nch] */
{
	long i, nrow=nrh-nrl+1,ncol=nch-ncl+1;
	double **m;

	/* allocate pointers to rows */
	m=(double **) malloc((size_t)((nrow+NR_END)*sizeof(double*)));
	if (!m) nrerror("allocation failure 1 in matrix()");
	m += NR_END;
	m -= nrl;

	/* allocate rows and set pointers to them */
	m[nrl]=(double *) malloc((size_t)((nrow*ncol+NR_END)*sizeof(double)));
	if (!m[nrl]) nrerror("allocation failure 2 in matrix()");
	m[nrl] += NR_END;
	m[nrl] -= ncl;

	for(i=nrl+1;i<=nrh;i++) m[i]=m[i-1]+ncol;

	/* return pointer to array of pointers to rows */
	return m;
}

void free_dmatrix(double **m, long nrl, long nrh, long ncl, long nch)
/* free a double matrix allocated by dmatrix() */
{
	free((FREE_ARG) (m[nrl]+ncl-NR_END));
	free((FREE_ARG) (m+nrl-NR_END));
}

void mergesort(double arr[],int low, int middle, int high){
	int n1 = middle-low+1;
	int n2 = high-middle;
	double temp_array_one[n1];
	double temp_array_two[n2];
	int i,j,k;
	
	/* Split into two sub-arrays*/
	
	for(i=0;i<n1;i++){
		temp_array_one[i] = arr[low+i]; 
	}
	for(i=0;i<n2;i++){
		temp_array_two[i] = arr[middle+1+i]; 
	}
	
	i=0;
	j=0;
	k=low;
	while(i<middle-low+1 && j<high-middle){
		if(temp_array_one[i]<=temp_array_two[j]){
			arr[k] = temp_array_one[i];
			i++;
		}
		else{
			arr[k] = temp_array_two[j];
			j++;
		}
		k++;
	}
	
	while (i < middle-low+1) {
        arr[k] = temp_array_one[i];
        i++;
        k++;
    }
    
    while (j < high-middle) {
        arr[k] = temp_array_two[j];
        j++;
        k++;
    }
}

void sort(double array[], int min, int max){
	if(min<max){
		int mid = min + (max-min)/2;
		sort(array,min,mid);
		sort(array,mid+1,max);
		mergesort(array,min,mid,max);
	}
	return;
}


