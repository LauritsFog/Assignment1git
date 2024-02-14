clear
close all
clc
set(groot,'defaultAxesFontSize',12)

% Setup
a = 0;
b = 1;

alpha = -1;
beta = 1.5;

epsilon = 0.1;

w0 = 1/2*(a-b+beta-alpha);
xbar = 1/2*(a+b-alpha-beta);

% Approximate solution from (2.104)
utilde = @(x) x-xbar+w0*tanh(w0*(x-xbar)/(2*epsilon));

h = (1/(2^5));

N = (b-a)/h;

x = linspace(a,b,N+1)';

U0 = utilde(x);

% Impose boundary conditions
U0(1) = alpha;
U0(end) = beta;

% maximum # iterations of Newton's method
maxit = 300;
tol = 10^(-5);

% Solve using Newton's method
U = Newton(@(U) ex2FdF(U,h,epsilon),U0,tol,maxit);

lnw = 1.5;

figure
plot(x,utilde(x),"LineWidth",lnw)
hold on
plot(x,U(:,end),'-o',"LineWidth",lnw)
xlabel("t")
ylabel("u")
legend("Analytical approximation","FDM solution",'Location','Southeast','Fontsize',15)
grid on
caption = sprintf("Plots of analytical approximation and FDM solution \n" + ...
                   "epsilon = %.2f, alpha = %.2f, beta = %.2f",epsilon,alpha,beta);
title(caption)

% maximum # iterations of Newton's method
maxit = 300;
tol = 10^(-10);

n = 12;

U = cell(1,n);
X = cell(1,n);
H = zeros(n,1);

for i = 1:n
    
    h = (1/(2^i));
    H(i) = h;
    
    N = (b-a)/h;
    
    x = linspace(a,b,N+1)';
    X{i} = x;
    
    U0 = utilde(x);
    
    % Impose boundary conditions
    U0(1) = alpha;
    U0(end) = beta;
    
    % Solve using Newton's method
    Uiter = Newton(@(U) ex2FdF(U,h,epsilon),U0,tol,maxit);

    U{i} = Uiter(:,end);

end

err = zeros(n-1,1);

for i = 1:(n-1)
    
    Ucoarse = U{i};
    Ufine = U{i+1};

    Xcoarse = X{i};
    Xfine = X{i+1};

    % err = computeL2Error1D(Ucoarse,Ufine,h(i));
    
    % We just compute the max difference between the previous coarse
    % solution and the new fine solution. As the solutions converge towards
    % the exact solution, these differences converge to 0. 
    err(i) = computeInfError1D(Ucoarse,Ufine,Xcoarse,Xfine);

end

figure
loglog(H(1:(end-1)),err,'-o',"LineWidth",lnw)
hold on
loglog(H(1:(end-1)),H(1:(end-1)).^2,'--',"LineWidth",lnw)
xlabel("h")
ylabel("||e||")
legend("FDM error","h^2",'Location','Southeast','Fontsize',15)
grid on
caption = sprintf("Convergence plot of the FDM \n" + ...
                   "epsilon = %.2f, alpha = %.2f, beta = %.2f",epsilon,alpha,beta);
title(caption)

% Solving using built-in matlab functions
% % Using approximate solution from (2.104)
% % guess = [u' u'']
% guess = @(x) [(2*epsilon + w0^2*sech(w0*(x - xbar)/(2*epsilon))^2)/(2*epsilon);
%               -w0^3*tanh(w0*(x - xbar)/(2*epsilon))*sech(w0*(x - xbar)/(2*epsilon))^2/(2*epsilon^2)];
% 
% solinit = bvpinit(x,guess);
% 
% sol = bvp4c(@(x,u) ex2odefun(x,u,epsilon), ...
%             @(ua,ub) ex2bcfun(ua,ub,alpha,beta),solinit);

