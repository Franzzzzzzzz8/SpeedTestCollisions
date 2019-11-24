public class HelloWorldApp {
    public static void main(String[] args) {
        int N = 5000 ; 
        double Dsqr = 0.05 ;
        double[][] particles = new double[N][3]  ; 
        for (int i=0 ; i<N ; i++)
            for (int j=0 ; j<3 ; j++)
                particles[i][j]=Math.random() ; 
                
        long start = System.currentTimeMillis(); 
        int count = 0 ;
        for (int i=0 ; i<N ; i++)
            for (int j=i+1 ; j<N ; j++)
            {
                double sum = 0 ;
                for (int k=0 ; k<3 ; k++)
                    sum += (particles[i][k]-particles[j][k])*(particles[i][k]-particles[j][k]) ;
                if (sum < Dsqr)
                    count +=1 ;
            }
        long end = System.currentTimeMillis();   
        System.out.println((end-start)/1000. + " " + (count));
        
        
        
        
        
    }
}
