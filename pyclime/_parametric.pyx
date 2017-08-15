import numpy as np
cimport numpy as cnp

cnp.import_array()

cdef extern from "parametric.h":
    void parametric(double *Shat, int *p, 
                    double *mu_input, 
                    double *lambdamin, 
                    int *nlambda, 
                    int *maxnlambda, 
                    double *iicov
                    );
    
def main(cnp.ndarray[double, ndim=2, mode="c"] Shat not None,
            cnp.ndarray[double, ndim=2, mode="c"] mu_input,
            double lambdamin,
            int nlambda,
            int maxnlambda,
            cnp.ndarray[double, ndim=2, mode="c"] iicov,
            ):
    
    cdef int p = Shat.shape[1]
    parametric(<double*> Shat.data,
               &p,
               <double*> mu_input.data,
               <double*> &lambdamin,
               &nlambda,
               &maxnlambda,
               <double*> iicov.data
              )

    return (Shat,mu_input,maxnlambda,iicov)