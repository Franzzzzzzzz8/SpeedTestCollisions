var particles=[] ;
var N = 5000;
var Dsqr = 0.05 ;

for (i=0; i<N ; i++)
{
    var tmp = [] ; 
    for (j=0 ; j<3 ; j++) 
    {tmp.push(Math.random()) ;} 
    particles.push(tmp) ; 
}       

console.time('Timing');
var count = 0 ; 
for (i=0 ; i<N ; i++)
  for (j=i+1 ; j<N ; j++)
     {
      var sum=0 ; 
      for (k=0 ; k<3 ; k++)
          sum += (particles[i][k]-particles[j][k])*(particles[i][k]-particles[j][k]) ; 
      if (sum < Dsqr)
          count ++ ;
     }
console.timeEnd('Timing');

console.log(count) ; 

