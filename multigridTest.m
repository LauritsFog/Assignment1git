clear
clc
close all
set(groot,'defaultAxesFontSize',12)

u = @(x,y) sin(4*pi*(x + y)) + cos(4*pi*x*y);  % exact solution
f = @(x,y) -16*(2*sin(4*pi*(x + y)) + cos(4*pi*x*y)*(x^2 + y^2))*pi^2; % RHS
g = @(x,y) sin(4*pi*(x + y)) + cos(4*pi*x*y);  % boundary conditions

% Tolerance
epsilon = 1.0E-10;

% Omega for jacobi iterations
omega = 2/3;

% Maximum iterations
maxiter = 1000;

% Pre- and post-smoothing amount
nsmooth = 3;

L = 12;

t = zeros(1,length(L));

for i = 1:L % Testing difference resolutions/recursion depths
    
    disp(i)

    l = i; % Recursion depth
    
    m=2^l-1; % Resolution
    
    U0 = zeros(m*m,1); % Initial guess

    [~,~,F] = constructRhs5(m,f,g); 

    timefun = @() multigrid(U0,F,l,omega,nsmooth,epsilon,maxiter);

    t(i) = timeit(timefun);
end

%%

refcon = 10^(-3)*(2.^(1:L)-1).^2;

figure
semilogy(1:L,t,'-o','LineWidth',1.5)
hold on
semilogy(1:L,refcon,'--','LineWidth',1.5)
legend("Multigrid","O(m^2)",'Location','northwest')
grid on
xlabel('l')
ylabel('CPU time (sek)')
title("CPU time of multigrid")



    