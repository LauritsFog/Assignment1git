clc
clear
close all

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
U = Newton(@ex2FdF,U0,h,epsilon,tol,maxit);

lnw = 1.5;

figure
plot(x,utilde(x),"LineWidth",lnw)
hold on
plot(x,U(:,end),"LineWidth",lnw)
legend("Approximation","Numerical solution",'Location','Southeast','Fontsize',15)
grid on

% maximum # iterations of Newton's method
maxit = 300;
tol = 10^(-5);

U = cell(1,8);

n = 8;

for i = 2:n
    
    h = (1/(2^i));
    
    N = (b-a)/h;
    
    x = linspace(a,b,N+1)';
    
    U0 = utilde(x);
    
    % Impose boundary conditions
    U0(1) = alpha;
    U0(end) = beta;
    
    % Solve using Newton's method
    Uiter = Newton(@ex2FdF,U0,h,epsilon,tol,maxit);

    U{i-1} = Uiter(:,end);

end

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

