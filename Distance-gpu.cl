/*
Code that contains kernels to run on accelerator in parallel. A kernel 
represents the basic unit of executable code. Each kernel will be 
executed on one work item ("pixel") of your parallel task:
1 work item = 1 "pixel" in your image 
A practical application may generate thousands or even millions of 
work-items, but for the simple task of adding 64 numbers, 
eight work-items will suffice. The program file add_numbers.cl 
contains a function called add_numbers that performs this operation. 
Like all kernel functions, it returns void and its name is preceded by 
the __kernel identifier.
The kernel has 64 values to add together and eight work-items with 
which to add them. After each work-item computes its sum of eight 
values, these partial results will be added together to form a sum for 
the entire group. In the end, the kernel will return two sums — one for 
each work-group executing the kernel.
data <===== input_buffer
group_result <===== sum_buffer
*/

__kernel void vector_add(__global const double *particles, __global int *ncontacts) {
 
    // Get the index of the current element to be processed
    int i = get_global_id(0);
    int j = get_global_id(1) ; 
    if (i>=j) return ; 
    // Do the operation
    double dst = (particles[3*i+0]-particles[3*j+0])*(particles[3*i+0]-particles[3*j+0]) + 
                 (particles[3*i+1]-particles[3*j+1])*(particles[3*i+1]-particles[3*j+1]) +
                 (particles[3*i+2]-particles[3*j+2])*(particles[3*i+2]-particles[3*j+2]) ; 
    
    if (dst<0.05) atomic_inc(ncontacts) ; 
}
