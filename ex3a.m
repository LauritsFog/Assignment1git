

m = 50;
u = @(x,y) sin(4*pi*(x + y)) + cos(4*pi*x*y);

f = @(x,y) -16*(2*sin(4*pi*(x + y)) + cos(4*pi*x*y)*(x^2 + y^2))*pi^2;

% g = @(x,y) x^2 + y^2;

g = @(x,y) sin(4*pi*(x + y)) + cos(4*pi*x*y);

m = 50;
A=poisson5(m);
[Xint,Yint,b] = constructRhs5(m,f,g);
[X,FLAG,RELRES,ITER,RESVEC] = pcg(-A, -b, 1e-8, 1000);
lnw = 1.5;

fig = figure;
semilogy(RESVEC/norm(b),'-.',"LineWidth",lnw)
caption = sprintf("Resdidual error, using Matlab builtin pcg for solving AU=F\n");
grid on
xlabel("Iterations")
ylabel("Residual")
saveas(fig, "Figures/ex3a.png")

