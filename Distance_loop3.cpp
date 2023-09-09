#include <boost/random.hpp>
#include <cstdlib>
#include <cstdio>
#include <valarray>
#include <chrono>
#include <algorithm>
#include <numeric>
#include <ranges>

#define N 5000

using namespace std ; 

int main (int argc, char *argv[])
{
 boost::random::mt19937 rng(std::time(0)); 
 boost::random::uniform_01<boost::mt19937> rand(rng) ; 
 auto start = std::chrono::high_resolution_clock::now();
 auto elapsed = std::chrono::high_resolution_clock::now()-start;   
 
 valarray <valarray <double> > particles  ; 
 particles.resize(N) ; 
 for (auto &v: particles) v.resize(3) ;
  
 for (auto & v : particles)
     for (auto & w: v)
         w = rand() ; 
 
 double Dsqr=0.05 ; 
 
 start = std::chrono::high_resolution_clock::now();
 double sum ; 
 int count=0 ; 
 for (int i=0 ; i<N ; i++)
     for (int j=0 ; j<N ; j++)
     {
      if (i==j) break ; 
      sum=((particles[i]-particles[j])*(particles[i]-particles[j])).sum() ;
      if (sum < Dsqr)
          count ++ ;
     }
 elapsed = std::chrono::high_resolution_clock::now()-start; 
 auto duration= std::chrono::duration_cast<std::chrono::microseconds>(elapsed).count() ; 
 printf("%g %d\n", duration/1000000., count) ; 
    
}
