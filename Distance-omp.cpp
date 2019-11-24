#include <boost/random.hpp>
#include <cstdlib>
#include <cstdio>
#include <vector>
#include <chrono>
#include <algorithm>
#include <numeric>
#include <omp.h>
#define OMP_NUM_THREADS 4

#define N 5000

using namespace std ; 

int main (int argc, char *argv[])
{
 boost::random::mt19937 rng; 
 boost::random::uniform_01<boost::mt19937> rand(rng) ; 
 auto start = std::chrono::high_resolution_clock::now();
 auto elapsed = std::chrono::high_resolution_clock::now()-start;   
 
 vector <vector <double> > particles (N, vector<double>(3,0))  ; 
 for (auto & v : particles)
     for (auto & w: v)
         w = rand() ; 
 
 double Dsqr=0.05 ;
 int count ;  
 
 start = std::chrono::high_resolution_clock::now();

 #pragma omp parallel for reduction(+:count)
 for (int i=0 ; i<N ; i++)
     for (int j=i+1 ; j<N ; j++)
     {
      double sum=0 ; 
      for (int k=0 ; k<3 ; k++)
          sum += (particles[i][k]-particles[j][k])*(particles[i][k]-particles[j][k]) ; 
      if (sum < Dsqr)
          count ++ ;
     }
 elapsed = std::chrono::high_resolution_clock::now()-start; 
 auto duration= std::chrono::duration_cast<std::chrono::microseconds>(elapsed).count() ; 
 
 printf("%g %d\n", duration/1000000., count) ; 
    
}
