import numpy as np
cimport numpy as cnp

cnp.import_array()

cdef extern from "dantzig.h":
    void dantzig(double *X2, double *Xy,
                double *BETA0,
                int *d0, double *lambdareg, int *nlambda, 
                double *lambdalist
                );

def main(cnp.ndarray[double, ndim=2, mode="c"] X2 not None,
            cnp.ndarray[double, ndim=2, mode="c"] Xy not None,
            cnp.ndarray[double, ndim=2, mode="c"] BETA0,
            int d0,
            double lambdareg,
            int nlambda,
            cnp.ndarray[double, ndim=1, mode="c"] lambdalist,            
            ):
    
    dantzig(<double*> X2.data, 
            <double*> Xy.data,
            <double*> BETA0.data,
            &d0,
            <double*> &lambdareg,
            &nlambda,
            <double*> lambdalist.data
            );

    return (BETA0,X2,Xy)