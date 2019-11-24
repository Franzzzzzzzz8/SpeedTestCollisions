#include <boost/random.hpp>
#include <cstdlib>
#include <cstdio>
#include <vector>
#include <chrono>
#include <algorithm>
#include <numeric>
#include <armadillo>
//#include <omp.h>

#define N 5000

int main (int argc, char *argv[])
{
 boost::random::mt19937 rng; 
 boost::random::uniform_01<boost::mt19937> rand(rng) ; 
 auto start = std::chrono::high_resolution_clock::now();
 auto elapsed = std::chrono::high_resolution_clock::now()-start;   
 
 arma::mat particles (N, 3, arma::fill::randu) ; 
 
 double Dsqr=0.05 ; 
 
 start = std::chrono::high_resolution_clock::now();
 double sum ; 
 int count=0 ; 
 
 particles.each_row(
     [&](arma::vec& val) {
         particles.each_row(
            [&](arma::vec & val2){
         arma::square(val2 - val) ;}) ;
        //arma::sum(arma::sum(arma::square(particles - val),1)<Dsqr) ; 
    }) ; 

// for i in range (0,N):
//    count += np.sum(np.sum((particles-particles[i])**2, axis=1)<Dsqr) ;
 
 elapsed = std::chrono::high_resolution_clock::now()-start; 
 auto duration= std::chrono::duration_cast<std::chrono::microseconds>(elapsed).count() ; 
 
 printf("%g %d\n", duration/1000000., count) ; 
    
}
