!************************************************************
! Visibility Graph Calculation Subroutine
!
! This subroutine, ComputeVGAndDegreeDistribution, takes a time series
! as input and generates the Visibility Graph (VG) as well as its degree
! distribution, in-degree distribution, and out-degree distribution.
! The VG is represented as an adjacency matrix, and the degree distributions
! provide statistics on node degrees.
!
! Input Parameters:
!   N - The size of the time series
!   TimeSeries - An array containing the time series data
!
! Output Parameters:
!   VG - A 2D array representing the adjacency matrix of the Visibility Graph
!   DegreeDistribution - An array storing the total degree distribution
!   InDegreeDistribution - An array storing the in-degree distribution
!   OutDegreeDistribution - An array storing the out-degree distribution
!
! Algorithm:
! - The subroutine iterates through the time series data, computing edges
!   in the VG based on specific criteria.
! - The adjacency matrix VG is filled, and degree distributions are updated.
!
! Note:
! - This subroutine should be compiled into a shared library and can be
!   called from R using the .Fortran interface.
!
! Author: Mateus Gonzalez de Freitas Pinto (2024)
! Adapted from original .f90 code of Lucas Lacasa to be callable from R
! Please cite the originals!
!
![1] From time series to complex networks: the visibility graph
!Lucas Lacasa, Bartolo Luque, Fernando Ballesteros, Jordi Luque, Juan C. Nuño
!PNAS, vol. 105, no. 13 (2008) 4972-4975
!
![2] Time series irreversibility: a visibility graph approach
!Lucas Lacasa, Angel Nuñez, Edgar Roldán, Juan MR Parrondo, Bartolo Luque
!European Physical Journal B 85, 217 (2012) 
!
!************************************************************

subroutine ComputeVGAndDegreeDistribution(N, TimeSeries, VG, DegreeDistribution, InDegreeDistribution, OutDegreeDistribution)
    implicit none

    integer, intent(in) :: N
    double precision, intent(in) :: TimeSeries(N)
    integer, dimension(N, N), intent(out) :: VG
    integer, dimension(N), intent(out) :: DegreeDistribution, InDegreeDistribution, OutDegreeDistribution

    integer :: i, j
    double precision :: criteria, pending

    ! Initialize VG and degree distribution arrays
    VG = 0
    DegreeDistribution = 0
    InDegreeDistribution = 0
    OutDegreeDistribution = 0

    do i = 1, N - 1
        do j = i + 1, N
            criteria = TimeSeries(j) - TimeSeries(i)
            pending = (TimeSeries(j) - TimeSeries(i)) / (j - i)
            
            ! Check the criteria and update VG and degree distributions
            if (criteria <= pending) then
                VG(i, j) = 1
                VG(j, i) = 1
                DegreeDistribution(i) = DegreeDistribution(i) + 1
                DegreeDistribution(j) = DegreeDistribution(j) + 1
                OutDegreeDistribution(i) = OutDegreeDistribution(i) + 1
                InDegreeDistribution(j) = InDegreeDistribution(j) + 1
            end if
        end do
