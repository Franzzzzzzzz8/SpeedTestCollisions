use rand::prelude::*;


fn main() {
    let N = 5000 ; 
    let mut rng = rand::thread_rng();
    let mut vec: Vec<f64> = Vec::with_capacity(N);
    for _ in 0..vec.capacity() {
        vec.push(rng.gen::<f64>());
    };
}

