# TGP

Instructions for TGP Algorithm:

- tgp.m: The file implements the TGP algorithm as a function. The **tgp** function takes in measurement matrix A and data vector b and outputs the signal with its support.
- tgpthresh.m: The file implements finding the thresholding parameter $\tau$ as a function. The **tgpthresh** function takes in measurement matrix A and outputs $\tau$.
- main_tgp.m: The file runs TGP algorithm. \**RUN THIS FILE*\*. Change matrix measurement matrix A according to your needs.

For comparision between TGP and CoSaMP:

- ptgp.m and pcos.m are auxiliary functions that output performance data.
- compareSparseRecoveryAVE.m: \**RUN THIS FILE*\* to compare performance between TGP and CoSaMP. The file will output three performance graphs: Runtime, Recovered Support, and False Discoveries.
