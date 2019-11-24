/*#include <boost/random.hpp>
#include <cstdlib>
#include <cstdio>
#include <vector>
#include <chrono>
#include <algorithm>
#include <numeric>

#define N 5000

using namespace std ; */


#include <stdio.h> 

int main() {
  int nDevices;

  cudaGetDeviceCount(&nDevices);
  for (int i = 0; i < nDevices; i++) {
    cudaDeviceProp prop;
    cudaGetDeviceProperties(&prop, i);
    printf("Device Number: %d\n", i);
    printf("  Device name: %s\n", prop.name);
    printf("  Memory Clock Rate (KHz): %d\n",
           prop.memoryClockRate);
    printf("  Memory Bus Width (bits): %d\n",
           prop.memoryBusWidth);
    printf("  Peak Memory Bandwidth (GB/s): %f\n\n",
           2.0*prop.memoryClockRate*(prop.memoryBusWidth/8)/1.0e6);
  }
  printf("No device :(") ; 
}


/*
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
 
 start = std::chrono::high_resolution_clock::now();
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
 elapsed = std::chrono::high_resolution_clock::now()-start; 
 auto duration= std::chrono::duration_cast<std::chrono::microseconds>(elapsed).count() ; 
 
 printf("%g %d\n", duration/1000000., count) ; 
    
}
*/
