#pythran export distance(float[][], int, float)
import numpy as np
def distance(particles, N, Dsqr) :
    sum = 0 ; 
    count = 0 ;
    for i in range (0, N):
        for j in range (i+1, N) :
            sum=0 ; 
            for k in range(0,3):
                sum += (particles[i][k]-particles[j][k])*(particles[i][k]-particles[j][k]) ;
            if (sum < Dsqr):
                count +=1 
    return count ; 
    





