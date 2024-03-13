

% Using the same functions as in exercise 2b
u = @(x,y) sin(4*pi*(x + y)) + cos(4*pi*x*y);
f = @(x,y) -16*(2*sin(4*pi*(x + y)) + cos(4*pi*x*y)*(x^2 + y^2))*pi^2;
g = @(x,y) sin(4*pi*(x + y)) + cos(4*pi*x*y);

m = 50;  % 50 data points.

A=poisson5(m);  % create A-matrix

[Xint,Yint,b] = constructRhs5(m,f,g);  %create right hand side of diff equation
[X,FLAG,RELRES,ITER,RESVEC] = pcg(-A, -b, 1e-8, 1000);  % Calling built-in solver

% Plotting figure
lnw = 1.5;
fig = figure;
semilogy(RESVEC/norm(b),'-.',"LineWidth",lnw)
caption = sprintf("Resdidual error, using Matlab builtin pcg for solving AU=F\n");
grid on
xlabel("Iterations")
ylabel("Residual")
saveas(fig, "Figures/ex3a.png")

