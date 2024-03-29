clear
clc
close all

% In this exercise we want to test the convergence rate of Matlabs built-in
% solver.

% Using the same functions as in exercise 2b
u = @(x,y) sin(4*pi*(x + y)) + cos(4*pi*x*y);
f = @(x,y) -16*(2*sin(4*pi*(x + y)) + cos(4*pi*x*y)*(x^2 + y^2))*pi^2;
g = @(x,y) sin(4*pi*(x + y)) + cos(4*pi*x*y);

m = 127;  % 127 data points as in the convergence test for the vcycle solution

A = -poisson5(m);  % create A-matrix
[Xint,Yint,b] = constructRhs5(m,f,g);  % create right hand side of diff equation
b = -b;

% Without precondition
[~,FLAG,~,~,RESVEC] = pcg(A, b, 1e-8, 1000);  % Calling built-in solver
conv_rate = 2*(sqrt(cond(A))-1)/(sqrt(cond(A))+1);
fprintf("Convergence rate: %f",conv_rate)

% With precondition
L = ichol(A); % precondition matrix, incomplete cholesky factorization
[~,FLAG_pre,~,~,RESVEC_pre] = pcg(A, b, 1e-8, 1000,L,L');  % Calling built-in solver


% Plotting figure
lnw = 1.5;
fig = figure;
semilogy(RESVEC/norm(b),'-.',"LineWidth",lnw)
hold on
semilogy(RESVEC_pre/norm(b),'-.',"LineWidth",lnw)
caption = sprintf("Resdidual error using pcg\n");
grid on
xlabel("Iterations")
ylabel("Residual")
legend("Without preconditioner","With preconditioner")
title(caption)
saveas(fig, "Figures/ex3a.png")

