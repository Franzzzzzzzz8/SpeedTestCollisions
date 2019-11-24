#include <cstdio>
#include <cstdlib>
#include <vector>


using fp = double ; 

int main (int argc, char * argv[])
{
    FILE *out = fopen("Bouncing.txt", "w") ; 
    fp X=1, V=0, A=0, Xnext, Anext ;
    fp R=0.1, K=1000, g=1 ; 
    int tdump = 10 ; 
    
    fp maxT=10000000, dt=0.001 ;
    
    fp i ; int n=0 ; int sgn, sgnprev ; int nn=0 ; 
    for (i=0 ; i<maxT ; i+=dt, n++)
    {
        Xnext=X+V*dt + A*dt*dt/2.L ; 
        
        Anext = -g ;
        if (Xnext < R) 
            Anext += -K*(Xnext-R) ;
        
        sgn = (Xnext-X)>0 ;
        if (sgnprev == 1 && sgn == 0)
        {
            if (nn%100000)
                fprintf(out, "%g %.10f %.10f %.10f\n", i, X, V, A) ;
            nn++ ; 
            //fprintf(out, "%Lg %.10Lf %.10Lf %.10Lf\n", i, X, V, A) ;
        }
        V = V + (Anext+A)*dt/2. ; 
        X = Xnext ; 
        A = Anext ; 
        sgnprev=sgn ; 
        
        if (n%10000) printf("\r%f", i) ; 
    }
    
    fclose(out) ; 
}
