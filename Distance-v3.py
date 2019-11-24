import numpy as np ; 
import random as random ; 
import time as time ; 
from numba import jit ; 

@jit
def distance (particles):
    count = 0 ; 
    for i in range (0, N):
        for j in range (i+1, N) :
            sum=0 ; 
            for k in range(0,3):
                sum += (particles[i][k]-particles[j][k])*(particles[i][k]-particles[j][k]) ;
            if (sum < Dsqr):
                count +=1 
    return count ; 

N=5000 ; 
particles = np.random.rand(N,3) ; 
Dsqr = 0.05 ; 

a=time.perf_counter() ; 
sum = 0 ; 
count = distance(particles) ; 

count = count ; 
b=time.perf_counter() ; 
        
    
print(str(b-a) + " " + str(count) ) ; 




