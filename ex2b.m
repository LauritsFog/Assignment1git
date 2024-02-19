clear
clc
close all

u = @(x,y) sin(4*pi*(x + y)) + cos(4*pi*x*y);

f = @(x,y) -16*(2*sin(4*pi*(x + y)) + cos(4*pi*x*y)*(x^2 + y^2))*pi^2;

g = @(x,y) sin(4*pi*(x + y)) + cos(4*pi*x*y);

m = 100;

[X,Y,U] = solvePoisson5(m,f,g);

figure
mdl = scatteredInterpolant(X, Y, U);
[xg, yg] = meshgrid(unique(X), unique(Y));
zg = mdl(xg, yg);
surf(xg,yg,zg)

g = @(x,y) x^2 + y^2;

m = 100;

[X,Y,U] = solvePoisson5(m,f,g);

figure
mdl = scatteredInterpolant(X, Y, U);
[xg, yg] = meshgrid(unique(X), unique(Y));
zg = mdl(xg, yg);
surf(xg,yg,zg)