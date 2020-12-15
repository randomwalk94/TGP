function [x, support_x] = tgp(A,dat,tau)

%% Parameters
[N, K] = size(A);

tol = 0.0001;
%% normalizing the columns to 1
aux = vecnorm(A); 
An = A./aux;
AT = An';

%% Thresholding parameter
tau = tau;

%% TGP

count=0;
support_x=[];
datt=dat;
while (count<1)

    x = max(abs(AT*dat) - tau*norm(dat),0);         % Thresholding
    
    nonzero = find(x)'; % find the support at each step
    
    if isempty(nonzero) % if nothing is returned, end the loop
        count=count+1;
    else
        count=0;
    end
    
    support_x = sort(unique([support_x, nonzero])); 
    dat = dat - An(:,nonzero)*((An(:,nonzero)'*An(:,nonzero))\(An(:,nonzero)'*dat)); % project data on the complement of the support
    if norm(dat)<tol % if nothing new is recovered, end the loop
        break;
    end    
end
x = zeros(K,1);
x(support_x) = (An(:,support_x)'*An(:,support_x))\(An(:,support_x)'*datt);


 
end