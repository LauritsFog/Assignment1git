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

h = (1/(2^3));

N = (b-a)/h;

x = linspace(a,b,N+1)';

U0 = utilde(x);

% Impose boundary conditions
U0(1) = alpha;
U0(end) = beta;

% # iterations of Newton's method
n = 100;

% Solve using Newton's method
U = Newton(@ex2FdF,U0,h,epsilon,alpha,beta,n);

% Using approximate solution from (2.104)
% guess = [u' u'']
guess = @(x) [(2*epsilon + w0^2*sech(w0*(x - xbar)/(2*epsilon))^2)/(2*epsilon);
              -w0^3*tanh(w0*(x - xbar)/(2*epsilon))*sech(w0*(x - xbar)/(2*epsilon))^2/(2*epsilon^2)];

solinit = bvpinit(x,guess);

sol = bvp4c(@(x,u) ex2odefun(x,u,epsilon), ...
            @(ua,ub) ex2bcfun(ua,ub,alpha,beta),solinit);

lnw = 1.5;

figure
plot(x,utilde(x),"LineWidth",lnw)
hold on
plot(sol.x,sol.y(1,:),"LineWidth",lnw)
hold on
plot(x,U(:,end),"LineWidth",lnw)
legend("Approximation","Matlab sol","Newton sol",'Location','Southeast','Fontsize',15)
grid on

%%

col = winter(n);

figure
plot(x,U)
colororder(col)

%%

% Get solution at our mesh nodes
% solinter = interp1(sol.x,sol.y(1,:),x');
% 
% [F,J] = ex2FdF(solinter',h,epsilon);

n = 5;

% First order centered difference
D1 = constructCenteredD1(n)./h;
% Second order centered difference
D2 = constructCenteredD2(n)./(h^2);

fun = @(U) epsilon.*D2*U+(diag(D1*U)-eye(n))*U;

% Estimate jacobian at final positions
[jac,~] = jacobianest(@(u) fun(u), U0);

[F,dF] = ex2FdF(U0,h,epsilon);

disp(full(dF))
disp(jac)

%%

[F,J] = ex2FdF(U(:,end),h,epsilon);

disp(-J\F)