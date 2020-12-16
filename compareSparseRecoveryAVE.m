
%%%% Compare the performance between TGP and CoSaMP in various settings

% Codenames
% cos = CoSaMP
% tgp = TGP

clear all

Mstep = 5;
% We vary sparsity level from 1 to 50

cycles = 20;
MM = zeros(1,Mstep);
step=1;

falsecos = zeros(1,Mstep);
falsetgp = zeros(1,Mstep);

suppcos = zeros(1,Mstep);
supptgp = zeros(1,Mstep);

ttcos = zeros(1,Mstep);
tttgp = zeros(1,Mstep);

showup = 0;
for ccc=1:cycles
while (step<Mstep+1)
    M = step;
    MM(step) = step;
    N = 1000;                    % # measurments
    K = 2*N;                    % # unknowns

    delta =0;                 % level of noise

    
    ac = 1;                   % ac=0 for Gaussian matrix, ac=1 for Fourier matrix.
    if ac == 0
        A = randn(N,K);              % measurement matrix with gaussian entries
    else
        A = dftmtx(K);             % measurement matrix with gaussian entries
        aux = randperm(K);
        pos = aux(1:N)';
        A = A(pos,:);
    end
    aux = vecnorm(A); 
    An = A./aux;
   
    
    %% Strength of the signal
    aref = 1;
    bref = 1;

    %% Unknown vector
    aux = randperm(K);
    pos = unique(aux(1:M));
    xref = zeros(K,1);
    xref(pos) = aref +  bref*randn(M,1);
    
    %% Data
    dat0 = An*xref;
    noise = randn(size(dat0));
    noise = delta*norm(dat0)*noise/norm(noise);
    dat = dat0 + noise;

    %% Performance data 

    [falserecover1,supp1,tt1] = pcos(A,xref,dat,showup);
    falsecos(step) = falsecos(step) + falserecover1/cycles;
    suppcos(step) = suppcos(step)+supp1/cycles;
    ttcos(step) = ttcos(step)+tt1/cycles;
    
    
    [falserecover2,supp2,tt2] = ptgp(A,xref,dat,showup);
    falsetgp(step) = falsetgp(step) + falserecover2/cycles;
    supptgp(step) = supptgp(step)+supp2/cycles;
    tttgp(step) = tttgp(step)+tt2/cycles;
    
    step = step +1;

end
step =1;
end

figure(11)
plot(1:Mstep,falsecos,'g-o',1:Mstep,falsetgp,'r-*')
xlabel('M = Sparsity')
ylabel('False Discoveries')
title('False Discoveries of CoSaMP (GREEN) and TGP (RED)')

figure(12)
plot(1:Mstep,suppcos,'g-o',1:Mstep,MM,'b-',1:Mstep,supptgp,'r-*')
xlabel('M = Sparsity')
ylabel('Recovered Support')
title('Recovered Support of CoSaMP (GREEN) and TGP (RED)')

figure(13)
plot(1:Mstep,ttcos,'g-o',1:Mstep,tttgp,'r-*')
xlabel('M = Sparsity')
ylabel('Recovery time (in s)')
title('Recovery time of CoSaMP (GREEN) and TGP (RED)')

