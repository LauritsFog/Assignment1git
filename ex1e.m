


% convergence test plot
u = @(x) exp(cos(x));
h = 0.1;

xbar = 0;

a_m1 = 3/8; 
a_0 = 6/8;
a_1 = -1/8;

err1 = zeros(1,n);
err2 = zeros(1,n);

H = zeros(1,n);
order3convergence = zeros(1,n);
order4convergence = zeros(1,n);


for j = 1:n
    
    h = 1/(2^j);
    H(j) = h;
    
    % Computing reference order 3 and 4 convergence
    order3convergence(j) = h^3;
    order4convergence(j) = h^4;
    
    u_appr = a_m1 * u(-h/2) + a_0 * u(h/2) + a_1 * u(3*h/2);
    err1(j) = abs(u(xbar) - u_appr);
end

lnw = 1.5;

figure
loglog(H, err1,'-o',"LineWidth",lnw)
hold on
loglog(H,order3convergence,'--',"LineWidth",lnw)
hold on
loglog(H,order4convergence,'--',"LineWidth",lnw)
hold on
legend("(-.5, .5, 1.5)","O(h^3)", "O(h^4)",'Location','Southeast','Fontsize',15)
caption = sprintf("Convergence plots using 3-point stencil \n");
title(caption)
grid on
xlabel("h")
ylabel("Error")

