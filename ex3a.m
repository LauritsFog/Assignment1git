clear all;close all; clc

m = 50;

f = @(x,y) -16*(2*sin(4*pi*(x + y)) + cos(4*pi*x*y)*(x^2 + y^2))*pi^2;

g = @(x,y) sin(4*pi*(x + y)) + cos(4*pi*x*y);


A = poisson5(m);

[Xint,Yint,b] = constructRhs5(m,f,g);

[X,FLAG,RELRES,ITER,RESVEC] = pcg(-A, -b, 1e-8, 1000);

conv_rate = max(abs(X(2:end)-X(1:end-1)));

fprintf("Estimated rate of convergence: %f\n", conv_rate)

lnw = 1.5;

fig = figure;
semilogy(RESVEC/norm(b),'-.',"LineWidth",lnw)
caption = sprintf("Resdidual error, using Matlab builtin pcg for solving AU=F\n");
grid on
xlabel("Iterations")
ylabel("Residual")
title(caption)
saveas(fig, "Figures/ex3a.png")
