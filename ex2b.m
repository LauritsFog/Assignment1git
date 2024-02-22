clear
clc
close all

u = @(x,y) sin(4*pi*(x + y)) + cos(4*pi*x*y);

f = @(x,y) -16*(2*sin(4*pi*(x + y)) + cos(4*pi*x*y)*(x^2 + y^2))*pi^2;

% g = @(x,y) x^2 + y^2;

g = @(x,y) sin(4*pi*(x + y)) + cos(4*pi*x*y);

m = 50;

[X,Y,U] = solvePoisson5(m,f,g);

figure
mdl = scatteredInterpolant(X, Y, U);
[xg, yg] = meshgrid(unique(X), unique(Y));
zg = mdl(xg, yg);
surf(xg,yg,zg)
xlabel("x")
ylabel("y")
zlabel("U")
caption = sprintf("5-point Laplacian FDM solution plot");
title(caption)

[X,Y,U] = solvePoisson9(m,f,g);

figure
mdl = scatteredInterpolant(X, Y, U);
[xg, yg] = meshgrid(unique(X), unique(Y));
zg = mdl(xg, yg);
surf(xg,yg,zg)
xlabel("x")
ylabel("y")
zlabel("U")
caption = sprintf("9-point Laplacian FDM solution plot");
title(caption)

M = 2.^(1:8);

n = length(M);

err5 = zeros(n,1);
err9 = zeros(n,1);
H = zeros(n,1);

for i = 1:n

    H(i) = 1/(M(i)+1);

    [X,Y,U5] = solvePoisson5(M(i),f,g);
    [~,~,U9] = solvePoisson9(M(i),f,g);
    
    udiscrete = arrayfun(u,X,Y);

    err5(i) = max(abs(udiscrete-U5));
    err9(i) = max(abs(udiscrete-U9));

end

% Reference convergence line
refcon2 = 10^2*H.^2;
refcon4 = 10^3*H.^4;

lnw = 1.5;

figure
loglog(H,err5,'-o','LineWidth',lnw)
hold on
loglog(H,err9,'-o','LineWidth',lnw)
hold on
loglog(H,refcon2,'--','LineWidth',lnw)
hold on
loglog(H,refcon4,'--','LineWidth',lnw)
grid on
legend("5-point FDM","9-point FDM","O(h^2)","O(h^4)",'Fontsize',15,Location = "southeast")
xlabel('h')
ylabel('Error')
caption = sprintf("Convergence plot of the 5- and 9-point FDM");
title(caption)

% M = 2.^(1:7);
% 
% p = 2;
% 
% varargin = {f,g};
% 
% figure
% convergencePlot(u,@solvePoisson5,M,p,varargin)
