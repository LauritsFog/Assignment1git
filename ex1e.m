% solution code for exercise 1.e

u = @(x) exp(cos(x));  % define u-function

xbar = 0;  % x-value for which we wish to approximate u

% a-values, as calculated in report
a_m1 = 3/8; 
a_0 = 6/8;
a_1 = -1/8;

% create empty array to store errors
err1 = zeros(1,n);

% create ampty array to store h-values for plotting
H = zeros(1,n);

% create empty arrays to store O(x^3) and O(x^4)
order3convergence = zeros(1,n);
order4convergence = zeros(1,n);

% loop over mesh precision 
for j = 1:n
    
    h = 1/(2^j);  % define mesh interval size
    H(j) = h;  % save this value in H, for plotting
    
    % Computing reference order 3 and 4 convergence
    order3convergence(j) = h^3;
    order4convergence(j) = h^4;
    
    % calculate approximation of u in point x0=0
    u_appr = a_m1 * u(-h/2) + a_0 * u(h/2) + a_1 * u(3*h/2);

    % calculate error from ground truth and save for plotting
    err1(j) = abs(u(xbar) - u_appr);
end


% plot error with O(x^3) and O(x^4)
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

