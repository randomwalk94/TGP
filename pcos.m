function [falserecover, supp, tt] = pcos(A,xref,dat,show)
% Performance of CoSaMP

[N,K] = size(A);
M = nnz(xref);                       % level of sparsity


%% Normalizing the columns to 1
aux = vecnorm(A); 
An = A./aux;

%% Iteration of CoSAMP
x = zeros(K,1);
v = dat;
step = 0;
nsteps = M;
s = floor(M);
sparx=[];
tic
while (step < nsteps)
    
    step = step +1;
    
    y = An'*v;                                % Signal proxy
    
    [sortedy, Omega] = sort(y,'descend');  
    Omega = Omega(1:2*s);                     % Identification

    sparx = find(x)';
    T = unique([sparx,Omega']);               % Support Merger
    
    b = zeros(K,1);
    b(T) = (An(:,T)'*An(:,T))\(An(:,T)'*dat); % Least Square
    
    [mb, sx] = maxk(b,s);
    x = zeros(K,1);
    x(sx) = b(sx);                             % Pruning

    v = dat - An*x;                            % Update sample

    

end

tt = toc;
%% Performance
supp = nnz(find((x~=0).*(xref~=0))');
falserecover = nnz(x) - nnz(find((x~=0).*(xref~=0))');

%% Display graph if show = 1 
if (show==1)
    figure(2)
    plot(1:K,abs(x),'k*',1:K,abs(xref),'go')
    title('Performance of CoSaMP')
end

end