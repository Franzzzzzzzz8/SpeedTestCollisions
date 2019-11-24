import numpy as np ; 
import random as random ; 
import time as time ; 
from numba import jit ; 

@jit
def distance (particles):
    count = 0 ; 
    for i in range (0,N):
        count += np.sum(np.sum((particles[i+1:]-particles[i])**2, axis=1)<Dsqr) ; 
    return (count)

N=5000 ; 
particles = np.random.rand(N,3) ; 
Dsqr = 0.05 ; 

a=time.perf_counter() ; 
sum = 0 ; 
count = distance(particles) ; 

count = count / 2 ; 
b=time.perf_counter() ; 
        
    
print(str(b-a) + " " + str(count) ) ; 




