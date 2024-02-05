
u = @(x) exp(cos(x));
d2u = @(x) -cos(x)*exp(cos(x)) + sin(x)^2*exp(cos(x));

h = 0.1;

xbar = 0.5;

% alpha = 2;
% beta = 2;
% 
% x = (xbar-alpha*h):h:(xbar+beta*h);
% 
% c =  fdcoeffV(2,xbar,x);
% 
% d2u_1 = c*u(x)';
% 
% alpha = 4;
% beta = 0;
% 
% x = (xbar-alpha*h):h:(xbar+beta*h);

% c =  fdcoeffV(2,xbar,x);
% 
% d2u_2 = c*u(x)';

% (4,0)
a1 = [11/(12*h^2), -56/(12*h^2), 114/(12*h^2), -104/(12*h^2), 35/(12*h^2)];
% (2,2)
a2 = [-1/(12*h^2), 16/(12*h^2), -30/(12*h^2), 16/(12*h^2), -1/(12*h^2)];

d2u_1 = 0;
d2u_2 = 0;

for i = -4:0
    d2u_1 = d2u_1 + u(xbar+i*h)*a1(i+5);
end

for i = -2:2
    d2u_2 = d2u_2 + u(xbar+i*h)*a2(i+3);
end

fprintf("Backward: %d \n", d2u_1)
fprintf("Centered: %d \n", d2u_2)
fprintf("Exact: %d \n", d2u(xbar))
