#include "mex.hpp"
#include "mexAdapter.hpp"

using matlab::mex::ArgumentList;
using namespace matlab::data;

class MexFunction : public matlab::mex::Function {
    ArrayFactory factory;
public:
    void operator()(ArgumentList outputs, ArgumentList inputs) {
        double sm = 0;
        const TypedArray<double> particles = inputs[0];
                
        int N = particles.getDimensions()[0] ;  
        double Dsqr = 0.05 ; 
        int count = 0 ; double sum ;  
        for (int i=0 ; i<N ; i++)
            for (int j=i+1 ; j<N ; j++)
            {
            sum=0 ; 
            for (int k=0 ; k<3 ; k++)
                sum += (particles[i][k]-particles[j][k])*(particles[i][k]-particles[j][k]) ; 
            if (sum < Dsqr)
                count ++ ;
            }
        outputs[0]=factory.createScalar(count) ;         
    }
};
