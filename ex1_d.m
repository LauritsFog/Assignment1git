
u = @(x) exp(cos(x));
d2u = @(x) -cos(x)*exp(cos(x)) + sin(x)^2*exp(cos(x));

h = 0.5;

xbar = 1;

alpha = 2;
beta = 2;

x = (xbar-alpha*h):h:(xbar+beta*h);

c =  fdcoeffV(2,xbar,x);

n = 14;

err1 = zeros(1,n);
err2 = zeros(1,n);

H = zeros(1,n);
order3convergence = zeros(1,n);
order4convergence = zeros(1,n);

for j = 1:n
    
    d2u_1 = 0;
    d2u_2 = 0;
    
    h = 1/(2^j);
    H(j) = h;
    
    % Computing reference order 3 and 4 convergence
    order3convergence(j) = h^3;
    order4convergence(j) = h^4;
    
    % alpha = 4;
    % beta = 0;
    % 
    % x = (xbar-alpha*h):h:(xbar+beta*h);
    % 
    % % (4,0)
    % a1 = fdcoeffV(2,xbar,x);
    % 
    % alpha = 2;
    % beta = 2;
    % 
    % x = (xbar-alpha*h):h:(xbar+beta*h);
    % 
    % % (2,2)
    % a2 = fdcoeffV(2,xbar,x);
    
    % (4,0)
    a1 = [11/(12*h^2), -56/(12*h^2), 114/(12*h^2), -104/(12*h^2), 35/(12*h^2)];
    % (2,2)
    a2 = [-1/(12*h^2), 16/(12*h^2), -30/(12*h^2), 16/(12*h^2), -1/(12*h^2)];

    for i = -4:0
        d2u_1 = d2u_1 + u(xbar+i*h)*a1(i+5);
    end

    for i = -2:2
        d2u_2 = d2u_2 + u(xbar+i*h)*a2(i+3);
    end

    err1(j) = abs(d2u(xbar) - d2u_1);

    err2(j) = abs(d2u(xbar) - d2u_2);
end

figure
loglog(H, err1,'-o')
hold on
loglog(H, err2,'-o')
hold on
loglog(H,order3convergence,'--')
hold on
loglog(H,order4convergence,'--')
legend(["(4,0)","(2,2)","h^4","h^3"])
xlabel("h")
ylabel("||e||")
