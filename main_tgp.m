%%%%%
% Testing file for TGP
%%%%



%% Parameters
N = 1600;                    % # measurments
K = 2*N;                    % # unknowns
M = 10;                     % level of sparsity

delta =0.5;                    % level of noise

A = randn(N,K);             % measurement matrix with gaussian entries

%% Normalizing the columns to cc1
aux = vecnorm(A); 
An = A./aux;

%% Thresholding parameter
tau = tgpthresh(A,0.05,0.15); % Depending on A, try different values of lowertau and uppertau


%% Data
if M>0
    aux = randperm(K);
    pos = aux(1:M);
    xref = zeros(K,1);
    xref(pos) =  1+  1*randn(M,1);   % true signal
    xref = xref/norm(xref);          % normalized true signal
    
    dat0 = An*xref;                  % data vector
    noise = randn(size(dat0));       % noise vector
    noise = delta*norm(dat0)*noise/norm(noise);     % noise vector with strength
    
    dat = dat0 + noise;              % data vector contaminated with noise
else
    xref = zeros(K,1);
    dat = randn(N,1);               % data vector is just a noise vector
end


%%%%% If you want to change A, dat, please change only the part above


%%%%% The part below should not be changed unless you know what to do
%% Running the TGP algorithm
[x, support_x] = tgp(A,dat,tau);


%% Plotting the results
figure(12)
plot(1:K,abs(x),'k*',1:K,abs(xref),'go')
title('Green circles are the true solution')

%% Checking the performance
support_recovered = nnz(find((x~=0).*(xref~=0))') % how many locations of the support the algorithm recovers
falserecover = nnz(x)-nnz(find((x~=0).*(xref~=0))') % number of false recoveries