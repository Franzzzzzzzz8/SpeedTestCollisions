import numpy as np ; 
import random as random ; 
import time as time ; 
import dstmodule as dst

N=5000 ; 
particles = np.random.rand(N,3) ; 
Dsqr = 0.05 ; 

a=time.perf_counter() ; 
count = Distance_module.distance(particles, N, Dsqr) ; 
b=time.perf_counter() ; 
print(str(b-a) + " " + str(count) ) ; 

