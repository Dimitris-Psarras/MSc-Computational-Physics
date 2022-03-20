#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define pi M_PI
#define NR_END 1
#define FREE_ARG char*

float ***u_xyt;

void nrerror(char error_text[]);
float ***f3tensor(long nrl, long nrh, long ncl, long nch, long ndl, long ndh);
void free_f3tensor(float ***t, long nrl, long nrh, long ncl, long nch,
	long ndl, long ndh);

int main(void){
	// Variable declaration
	int M = 50, N = 50;
	double x_start = 0;
	double x_end = 2*pi;
	double y_start = 0;
	double y_end = 2*pi;
	double t_start = 0;
	double t_end = 2*pi;
	double k = 4.0/5.0;
	double dx = (x_end-x_start)/ (double)(M-1);
	double dy = (y_end-y_start)/ (double)(N-1);
	double dt = pi/1200.0;
	int T = (t_end-t_start)/dt + 1;
	int i,j,t;
	u_xyt = f3tensor(0,M-1,0,N-1,0,T-1);

	// Initial & boundary conditions
	for(i=0; i<M; i++){
		for(j=0 ; j<N ; j++){
			if(i==0 || i==M-1 || j==0 || j==N-1){
				u_xyt[i][j][0] = 0;
			}
			else{
				u_xyt[i][j][0] = sin(i*dx)*sin((double)(i*dy) / (double)2.0);
		}
		}
	}

	// Forward-Time Centered-Space method (FTCS)
	
	for(t=1; t<T; t++){
		for(i=0; i<M; i++){
			for(j=0 ; j<N ; j++){
				if(i==0 || i ==M-1 || j==0 || j==N-1){
					u_xyt[i][j][t] = 0;
				}
				else{
					u_xyt[i][j][t] = u_xyt[i][j][t-1] + k*dt*(((u_xyt[i+1][j][t-1]-2.0*u_xyt[i][j][t-1]+u_xyt[i-1][j][t-1])/(pow(dx,2)))+((u_xyt[i][j+1][t-1]-2.0*u_xyt[i][j][t-1]+u_xyt[i][j-1][t-1])/(pow(dy,2))));
				}
			}
		}
	}

	// Write results in file (csv format)
	
	FILE *fp;
	fp = fopen("results.csv", "w+");
	for(t=0; t<T; t++){
		for(i=0; i<M; i++){
			for(j=0 ; j<N ; j++){
				if(j==N-1){
					fprintf(fp,"%lf\n",u_xyt[i][j][t]);
				}
				else{
					fprintf(fp,"%lf,",u_xyt[i][j][t]);
				}
			}
		}
	}
	fclose(fp);
	
	free_f3tensor(u_xyt,0,M-1,0,N-1,0,T-1);
	
	return 0;
}




void nrerror(char error_text[])
/* Numerical Recipes standard error handler */
{
	fprintf(stderr,"Numerical Recipes run-time error...\n");
	fprintf(stderr,"%s\n",error_text);
	fprintf(stderr,"...now exiting to system...\n");
	exit(1);
}

float ***f3tensor(long nrl, long nrh, long ncl, long nch, long ndl, long ndh)
/* allocate a float 3tensor with range t[nrl..nrh][ncl..nch][ndl..ndh] */
{
	long i,j,nrow=nrh-nrl+1,ncol=nch-ncl+1,ndep=ndh-ndl+1;
	float ***t;

	/* allocate pointers to pointers to rows */
	t=(float ***) malloc((size_t)((nrow+NR_END)*sizeof(float**)));
	if (!t) nrerror("allocation failure 1 in f3tensor()");
	t += NR_END;
	t -= nrl;

	/* allocate pointers to rows and set pointers to them */
	t[nrl]=(float **) malloc((size_t)((nrow*ncol+NR_END)*sizeof(float*)));
	if (!t[nrl]) nrerror("allocation failure 2 in f3tensor()");
	t[nrl] += NR_END;
	t[nrl] -= ncl;

	/* allocate rows and set pointers to them */
	t[nrl][ncl]=(float *) malloc((size_t)((nrow*ncol*ndep+NR_END)*sizeof(float)));
	if (!t[nrl][ncl]) nrerror("allocation failure 3 in f3tensor()");
	t[nrl][ncl] += NR_END;
	t[nrl][ncl] -= ndl;

	for(j=ncl+1;j<=nch;j++) t[nrl][j]=t[nrl][j-1]+ndep;
	for(i=nrl+1;i<=nrh;i++) {
		t[i]=t[i-1]+ncol;
		t[i][ncl]=t[i-1][ncl]+ncol*ndep;
		for(j=ncl+1;j<=nch;j++) t[i][j]=t[i][j-1]+ndep;
	}

	/* return pointer to array of pointers to rows */
	return t;
}

void free_f3tensor(float ***t, long nrl, long nrh, long ncl, long nch,
	long ndl, long ndh)
/* free a float f3tensor allocated by f3tensor() */
{
	free((FREE_ARG) (t[nrl][ncl]+ndl-NR_END));
	free((FREE_ARG) (t[nrl]+ncl-NR_END));
	free((FREE_ARG) (t+nrl-NR_END));
}
