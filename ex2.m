
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

h = (1/(2^4));

N = (b-a)/h;

x = linspace(a,b,N+1)';

U0 = utilde(x);

% Impose boundary conditions
U0(1) = alpha;
U0(end) = beta;

% [F,J] = ex2FdF(x,h,epsilon);

% # iterations of Newton's method
n = 50;

% Solve using Newton's method
U = Newton(@ex2FdF,U0,h,epsilon,alpha,beta,n);

% [xout,u] = ode45(@(t,y) ex2odefun(t,y,epsilon),[x(1),x(end)], [alpha,0]);

figure
plot(x,utilde(x))
% hold on
% plot(xout,u)
hold on
plot(x,U(:,end))