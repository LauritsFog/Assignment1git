% differential equation from exercise 2b
% the problem is on the form 
% nabla^2 u = u_xx + u_yy = f, for (x,y) in inner set
% u = g for (x, y) on the border

u = @(x,y) sin(4*pi*(x + y)) + cos(4*pi*x*y);  % ground truth, which we wish to arrive at
f = @(x,y) -16*(2*sin(4*pi*(x + y)) + cos(4*pi*x*y)*(x^2 + y^2))*pi^2;
g = @(x,y) sin(4*pi*(x + y)) + cos(4*pi*x*y);  % border conditions

% set recusion level and mesh size
L = 7;
m = 2^7-1;

% Form the right-hand side
[~,~,F] = constructRhs5(m,f,g); 

% set epsilon to small value, for error tolerance in loop 
epsilon = 1.0E-10;

% reset U to initial value
U_0 = zeros(m*m,1);
U = U_0;

% define omega. 2/3 is derived from plot of eigenvector analysis
omega = 2/3;
max_steps = 1000;

% for debugging purpose, we use the smoother to get to the true solution.
% and plot under way 
if 1==2
    for i = 1:max_steps
        U = smooth(U, omega, m, F);
    end
    plotU(m,U);
end

% reset U to initial values
U = U_0;

residual_hist = zeros(1, max_steps);
normalized_residual_hist = zeros(1, max_steps);

% loop over approximation procedure
for i=1:max_steps 
    R = F + Amult(U,m);  % how are we doing now? Lets print the normed residual
    residual_hist(i) = norm(R,2);
    normalized_residual_hist(i) = norm(R,2)/norm(F,2);
    fprintf('*** Outer iteration: %3d, rel. resid.: %e\n', ...
        i, norm(R,2)/norm(F,2));
    if(norm(R, 2)/norm(F, 2) < epsilon)
        break;
    end
    U = VCycle(U, F, L, omega, 3);  % enter recursive function that approximate solution
    %plotU(m,U);  % plot the solution so far.
    %pause(.5);
end



residual_hist = residual_hist(1:i);
normalized_residual_hist = normalized_residual_hist(1:i);

%m = 63;  % 63 data points as in the convergence test for the vcycle solution

A = -poisson5(m);  % create A-matrix

[Xint,Yint,b] = constructRhs5(m,f,g);  %create right hand side of diff equation
[X,FLAG,RELRES,ITER,RESVEC] = pcg(A, -b, 1e-8, 1000);  % Calling built-in solver

% With precondition
L = ichol(A); % precondition matrix, incomplete cholesky factorization
[~,FLAG_pre,~,~,RESVEC_pre] = pcg(A, -b, 1e-8, 1000,L,L');  % Calling built-in solver


% Plotting figure
lnw = 1.5;
fig = figure;
semilogy(RESVEC/norm(b),'-.',"LineWidth",lnw)
hold on
semilogy(RESVEC_pre/norm(b),'-.',"LineWidth",lnw)
semilogy(normalized_residual_hist,'-.',"LineWidth",lnw)
caption = sprintf("Convergence comparison");
grid on
xlabel("Iterations")
ylabel("Residual")
legend("CG","PCG","Multigrid")
saveas(fig, "Figures/ex3_comparison.png")