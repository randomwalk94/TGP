%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function to find optimal threshold for TGP
% 
% The function runs No Phantom Signal (NPS) test for the matrix A.
% For each tau, the function will check if A and tau pass the NPS test.
% This experiment is run "testn" times with the noise being random.
% The function will output a graph plotting the success rate for each tau.
% For each tau, success rate = (# of times TGP outputs empty set)/(testn)

% testn = the number of experiments run for each tau

% Input: matrix A
% Output: optimal_tau, a graph plotting success rate of tau

% If the output optimal_tau = -1, it means there is no tau in the interval
% [lowertau,uppertau] will satisfy the NPS test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function optimal_tau = tgpthresh(A,lowertau,uppertau)

%% Parameters
[N,K] = size(A);           % size of A

nonze = 0;
nno = 1;
success_tau = [];          % success rate vector for tau

testn= floor(sqrt(N));     % the number of experiments for each tau
steptau = 0.001;           % calibrate tau at 0.001 increment
optimal_tau = -1;
valid_tau = 0;
%% Normalizing columns of A
aux = vecnorm(A); 
An = A./aux;
AT = An';

%% Running the experiment
for tau = lowertau:steptau:uppertau
nophantom_counter = 0;    % count the number of successes

for i=1:testn

dat = randn(N,1);         % Initializing noise vecotr

x = max(abs(AT*dat) - tau*norm(dat),0);  % No Phantom Signal test

if norm(x) == 0            % check if x is zer0
    nophantom_counter = nophantom_counter + 1;
end

end
success_tau = [success_tau nophantom_counter/testn];

%% Find the optimal tau
%  Need to make sure that optimal tau is the smallest such that
%  nophantom_counter == testn

if nophantom_counter == testn
   if valid_tau == 0
    optimal_tau = tau; 
    valid_tau = 1;
   end
else
    valid_tau = 0;
    optimal_tau = -1;
end

end
figure(11)
plot(lowertau:steptau:uppertau,success_tau,'k*')
title("Calibration of Thresholding Parameter for matrix $A$");
end