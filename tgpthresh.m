%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function to find optimal threshold for TGP
% 
% The function runs No Phantom Signal (NPS) test for the matrix A.
% For each tau, the function will check if A and tau pass the NPS test.
% This experiment is run as a binary search testn times.

% testn = the number of experiments run for each tau

% Input: matrix A
% Output: optimal_tau, a graph plotting success rate of tau

% If the output optimal_tau = -1, it means uppertau
% [lowertau,uppertau] does not satisfy the NPS test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function optimal_tau = tgpthresh(A,lowertau,uppertau)

%% Parameters
[N,K] = size(A);           % size of A

success_tau = [];          % success rate vector for tau

testn = 50;     % the number of experiments for each tau
steptau = 0.001;           % calibrate tau at 0.001 increment
optimal_tau = -1;
%% Normalizing columns of A
aux = vecnorm(A); 
An = A./aux;
AT = An';

%confirm uppertau satisfies no phantom requirement
for i=1:testn
    dat = randn(N,1);         % Initializing noise vector

    x = max(abs(AT*dat) - uppertau*norm(dat),0);  % No Phantom Signal test

    if norm(x) ~= 0
        return
    end
end

%% Running the experiment
current_upper = uppertau;
current_lower = lowertau;

test_tau = [];
while(true)
    false_flag = false;
    tau = (current_upper + current_lower)/2;
    test_tau = [test_tau; tau];
    nophantom_counter = 0;    % count the number of successes

    for i=1:testn
        dat = randn(N,1);         % Initializing noise vector

        x = max(abs(AT*dat) - tau*norm(dat),0);  % No Phantom Signal test

        if norm(x) ~= 0            % check if x is zer0
            %tau is lower bound
            current_lower = tau;
            false_flag = true;
            break;
        end
    end
    if ~false_flag
       %tau is upper bound
       current_upper = tau;
    end
    %termination condition
    if current_upper - current_lower < steptau
        break;
    end
end
optimal_tau = current_upper;
end
