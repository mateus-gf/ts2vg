# ts2vg - an R program to turn time series to Visibility Graph

In this repository one can use an R code to map a time series as an input to a the Visibility Graph (VG).

It also computes its degree distribution, in-degree distribution, and out-degree distribution.

The VG is represented as an adjacency matrix, and the degree distributions provide statistics on node degrees.

The R function calls a Fortran90 subroutine, which can be compilled as a SO and callable from R. 
