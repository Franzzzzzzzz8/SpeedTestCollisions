use rand::prelude::*;
use std::time::Instant;

fn main() {
    let n = 5000 ; 
    let dsqr=0.05f64 ; 
    
    let mut rng = rand::thread_rng();
    let mut particles: Vec<f64> = Vec::with_capacity(n*3);
    for _ in 0..particles.capacity() {
        particles.push(rng.gen::<f64>());
    };
            
    let now = Instant::now();
    let mut count = 0;
    for i in 0..n 
    {
      for j in i+1..n
      {
        let mut sum=0f64 ; 
        for k in 0..3
        {
          sum += (particles[i*3+k]-particles[j*3+k])*(particles[i*3+k]-particles[j*3+k]) ; 
        }
        if sum < dsqr 
        {
          count +=1 ;
        }
      }
    }
    let elapsed = now.elapsed();
    
    println!("{:.2?} {}", elapsed, count) ; 
}

