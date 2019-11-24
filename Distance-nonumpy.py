import random as random ; 
import time as time ; 

N=5000 ; 
particles = [] ;
tmp=[1.,2.,3.] ; 
for i in range (0, N):
    tmp=[i,i+1,i-1]
    particles.append(tmp) ; 
for i in range (0,N):
    for j in range(0,3):
        particles[i][j]=random.uniform(0,1) ; 
Dsqr = 0.05 ; 

a=time.perf_counter() ; 
sum = 0 ; 
count = 0 ;
for i in range (0, N):
    for j in range (i+1, N) :
        sum=0 ; 
        for k in range(0,3):
            sum += (particles[i][k]-particles[j][k])*(particles[i][k]-particles[j][k]) ;
        if (sum < Dsqr):
            count +=1 
b=time.perf_counter() ; 
        
    
print(str(b-a) + " " + str(count) ) ; 




