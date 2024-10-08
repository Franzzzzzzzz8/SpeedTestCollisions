#include <stdio.h>
#include <stdlib.h>
#include <time.h>
 
#ifdef __APPLE__
#include <OpenCL/opencl.h>
#else
#include <CL/cl.h>
#endif
 
#define MAX_SOURCE_SIZE (0x100000)
 
int main(void) {
    // Create the two input vectors
    int i, j;
    const int LIST_SIZE = 5000;
    double * particles ; 
    particles = (double *) malloc(LIST_SIZE*3*sizeof(double)) ; 
 
    srand(time(0)); 
    for (i=0 ; i<LIST_SIZE ; i++)
        for (j=0 ; j<3 ; j++)
         particles[3*i+j]=rand()/(double)(RAND_MAX) ; 
     /*
    int *A = (int*)malloc(sizeof(int)*LIST_SIZE);
    int *B = (int*)malloc(sizeof(int)*LIST_SIZE);
    for(i = 0; i < LIST_SIZE; i++) {
        A[i] = i;
        B[i] = LIST_SIZE - i;
    }*/
 
    // Load the kernel source code into the array source_str
    FILE *fp;
    char *source_str;
    size_t source_size;
 
    fp = fopen("Distance-gpu.cl", "r");
    if (!fp) {
        fprintf(stderr, "Failed to load kernel.\n");
        exit(1);
    }
    source_str = (char*)malloc(MAX_SOURCE_SIZE);
    source_size = fread( source_str, 1, MAX_SOURCE_SIZE, fp);
    fclose( fp );
 
    // Get platform and device information
    cl_platform_id platform_id = NULL;
    cl_device_id device_id = NULL;   
    cl_uint ret_num_devices;
    cl_uint ret_num_platforms;
    cl_int ret = clGetPlatformIDs(1, &platform_id, &ret_num_platforms);
    ret = clGetDeviceIDs( platform_id, CL_DEVICE_TYPE_DEFAULT, 1, 
            &device_id, &ret_num_devices);
 
    // Create an OpenCL context
    cl_context context = clCreateContext( NULL, 1, &device_id, NULL, NULL, &ret);
 
    // Create a command queue
    cl_command_queue command_queue = clCreateCommandQueue(context, device_id, 0, &ret);
 
    // Create memory buffers on the device for each vector 
    cl_mem particles_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY, 
            3*LIST_SIZE * sizeof(double), NULL, &ret);
    //cl_mem b_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY,
    //        LIST_SIZE * sizeof(int), NULL, &ret);
    cl_mem ncontacts = clCreateBuffer(context, CL_MEM_WRITE_ONLY, 
            sizeof(int), NULL, &ret);
 
    // Copy the lists A and B to their respective memory buffers
    ret = clEnqueueWriteBuffer(command_queue, particles_mem_obj, CL_TRUE, 0,
            3*LIST_SIZE * sizeof(double), particles, 0, NULL, NULL);
    int arr[1]={0} ; 
    ret = clEnqueueWriteBuffer(command_queue, ncontacts, CL_TRUE, 0, 
            sizeof(int), arr, 0, NULL, NULL);
 
    // Create a program from the kernel source
    cl_program program = clCreateProgramWithSource(context, 1, 
            (const char **)&source_str, (const size_t *)&source_size, &ret);
 
    // Build the program
    ret = clBuildProgram(program, 1, &device_id, NULL, NULL, NULL);
 
    // Create the OpenCL kernel
    cl_kernel kernel = clCreateKernel(program, "vector_add", &ret);
 
    // Set the arguments of the kernel
    ret = clSetKernelArg(kernel, 0, sizeof(cl_mem), (void *)&particles_mem_obj);
    ret = clSetKernelArg(kernel, 1, sizeof(int), (void *)& ncontacts) ; 
    //ret = clSetKernelArg(kernel, 1, sizeof(cl_mem), (void *)&b_mem_obj);
    //ret = clSetKernelArg(kernel, 2, sizeof(cl_mem), (void *)&c_mem_obj);
 
    // Execute the OpenCL kernel on the list
    size_t global_item_size[2] = {LIST_SIZE,LIST_SIZE}; // Process the entire lists
    size_t local_item_size[2] = {64,64}; // Divide work items into groups of 64
    ret = clEnqueueNDRangeKernel(command_queue, kernel, 2, NULL, 
            global_item_size, local_item_size, 0, NULL, NULL);
 
    // Read the memory buffer C on the device to the local variable C
    //int *C = (int*)malloc(sizeof(int)*LIST_SIZE);
    int ncontact_res ;
    ret = clEnqueueReadBuffer(command_queue, ncontacts, CL_TRUE, 0, 
            sizeof(int), &ncontact_res, 0, NULL, NULL);
 
    // Display the result to the screen
    //for(i = 0; i < LIST_SIZE; i++)
    //    printf("%d + %d = %d\n", A[i], B[i], C[i]);
    printf("%d \n", ncontact_res) ;
    // Clean up
    ret = clFlush(command_queue);
    ret = clFinish(command_queue);
    ret = clReleaseKernel(kernel);
    ret = clReleaseProgram(program);
    ret = clReleaseMemObject(particles_mem_obj);
//     ret = clReleaseMemObject(b_mem_obj);
//     ret = clReleaseMemObject(c_mem_obj);
    ret = clReleaseCommandQueue(command_queue);
    ret = clReleaseContext(context);
    free(particles);
//     free(B);
//     free(C);
    return 0;
}
