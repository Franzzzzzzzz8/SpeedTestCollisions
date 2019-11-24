#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#define N 5000

int main (int argc, char *argv[])
{
 double particles[N][3] ;
 int i, j, k ; 
 
 srand(time(0)); 
 for (i=0 ; i<N ; i++)
     for (j=0 ; j<3 ; j++)
         particles[i][j]=rand()/(double)(RAND_MAX) ; 
         
 
 double Dsqr=0.05 ; 

 clock_t start, end;
 start = clock(); 
 double sum ; 
 int count=0 ; 
 for (int i=0 ; i<N ; i++)
     for (int j=i+1 ; j<N ; j++)
     {
      sum=0 ; 
      for (int k=0 ; k<3 ; k++)
          sum += (particles[i][k]-particles[j][k])*(particles[i][k]-particles[j][k]) ; 
      if (sum < Dsqr)
          count ++ ;
     }
 end = clock() ; 
 
 double cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC; 
 printf("%g %d\n", cpu_time_used, count) ; 
    
}
