clear
clc
close all

u = @(x,y) sin(4*pi*(x + y)) + cos(4*pi*x*y);

f = @(x,y) -16*(2*sin(4*pi*(x + y)) + cos(4*pi*x*y)*(x^2 + y^2))*pi^2;

% g = @(x,y) x^2 + y^2;

g = @(x,y) sin(4*pi*(x + y)) + cos(4*pi*x*y);

m = 100;

[X,Y,U] = solvePoisson5(m,f,g);

figure
mdl = scatteredInterpolant(X, Y, U);
[xg, yg] = meshgrid(unique(X), unique(Y));
zg = mdl(xg, yg);
surf(xg,yg,zg)

M = 2.^(1:6);

n = length(M);

err = zeros(n,1);
H = zeros(n,1);

for i = 1:n

    H(i) = 1/(M(i)+1);

    [X,Y,U] = solvePoisson5(M(i),f,g);
    
    udiscrete = arrayfun(u,X,Y);

    err(i) = max(abs(udiscrete-U));

end

% Reference convergence line
refcon = H.^2;

lnw = 1.5;

figure
loglog(H,err,'-','LineWidth',lnw)
hold on
loglog(H,refcon,'--','LineWidth',lnw)
grid on
legend("Error","Reference convergence (h^2)",Location = "southeast")
xlabel('h')
ylabel('||e||')
caption = sprintf("Convergence plot of the 5-point Laplacian FDM");
title(caption)

% M = 2.^(1:7);
% 
% p = 2;
% 
% varargin = {f,g};
% 
% figure
% convergencePlot(u,@solvePoisson5,M,p,varargin)
