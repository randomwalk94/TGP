

function [falserecover, supp, tt] = ptgp(A,xref,dat,showup)
% Performance for TGP

%% Parameters
[N, K] = size(A);
M = nnz(xref);                     % level of sparsity

%% Normalizing the columns to 1
aux = vecnorm(A); 
An = A./aux;

%% Thresholding parameter
tau = tgpthresh(An,0.05,0.2);

%% Iteration of TGP
x = zeros(K,1);             %Initialization of x
                                     
AT = An';

tic
count=0;
sparx=[];
datt=dat;
tol=0.0001;
while (count<1)
  
    xx = x;
    x = max(abs(AT*dat) - tau*norm(dat),0);         % Thresholding
    
    nonzero = find(x)'; % find the support at each step
    if isempty(nonzero)
        count=count+1;
    else
        count=0;
    end
    sparx = sort(unique([sparx, nonzero]));
   
    dat = dat - An(:,nonzero)*((An(:,nonzero)'*An(:,nonzero))\(An(:,nonzero)'*dat)); % project data on the complement of the support
    if norm(dat)<tol
        break;
    end

    
end
xx = zeros(K,1);
xx(sparx) = (An(:,sparx)'*An(:,sparx))\(An(:,sparx)'*datt);
tt = toc; %% runtime

%% Performance
supp = nnz(find((xx~=0).*(xref~=0))');
falserecover = nnz(xx)-nnz(find((xx~=0).*(xref~=0))');


%% Display graph if show = 1
if (showup==1)
    figure(1)
    plot(1:K,abs(x),'k*',1:K,abs(xref),'go')
    title('Green circles are the true solution')
end
  
 

 
