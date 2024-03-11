m = 50;
A=poisson5(m);
[Xint,Yint,b] = constructRhs5(m,f,g);
[X,FLAG,RELRES,ITER,RESVEC] = pcg(-A, -b, 1e-8, 1000);

fig = figure;
semilogy(RESVEC/norm(b),'-.',"LineWidth",lnw)
caption = sprintf("Resdidual error, using Matlab builtin pcg for solving AU=F\n");
grid on
xlabel("Iterations")
ylabel("Residual")
saveas(fig, "Figures/ex3a.png")
