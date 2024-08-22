rm(list = ls())
cat("\014")

# Load the shared library
dyn.load("D:\\Ts2Vg\\tsvg.so")

# Sample time series data
time_series <- rnorm(1024)

# Define the size of the time series
N <- length(time_series)

# Create arrays for VG and degree distribution
VG <- matrix(0L, nrow = N, ncol = N)
DegreeDistribution <- integer(N)
InDegreeDistribution <- integer(N)
OutDegreeDistribution <- integer(N)

# Call the Fortran subroutine
Visibility <- .Fortran("ComputeVGAndDegreeDistribution", N = as.integer(N), TimeSeries = as.double(time_series),
                       VG = as.integer(VG), DegreeDistribution = as.integer(DegreeDistribution),
                       InDegreeDistribution = as.integer(InDegreeDistribution),
                       OutDegreeDistribution = as.integer(OutDegreeDistribution))

# Print the results
cat("Visibility Graph:\n")
print(VG)

cat("Degree Distribution:\n")
print(DegreeDistribution)

cat("In-Degree Distribution:\n")
print(InDegreeDistribution)

cat("Out-Degree Distribution:\n")
print(OutDegreeDistribution)
