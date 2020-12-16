# TGP

Instructions for TGP Algorithm:

- tgp.m: [MATLAB function] The function implements TGP algorithm. The **tgp** function takes in measurement matrix A and data vector b, and outputs the signal with its support.
- tgpthresh.m: [MATLAB function] The function finds the thresholding parameter $\tau$ for measurement matrix A. The **tgpthresh** function takes in measurement matrix A and outputs $\tau$.
- main_tgp.m: The file tests TGP on synthetic data. \**RUN THIS FILE*\*. Change measurement matrix A according to your needs.

For comparision between TGP and CoSaMP:

- ptgp.m and pcos.m are auxiliary functions that output performance data.
- compareSparseRecoveryAVE.m: \**RUN THIS FILE*\* to compare performance between TGP and CoSaMP. The file will output three performance graphs: *Runtime, Recovered Support, and False Discoveries*.
