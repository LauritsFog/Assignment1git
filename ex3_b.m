% exact solution and RHS
% u=@(x,y) exp(pi*x).*sin(pi*y)+0.5*(x.*y).^2;
% f=@(x,y) x.^2+y.^2;

% differential equation from exercise 2b
% the problem is on the form 
% nabla^2 u = u_xx + u_yy = f, for (x,y) in inner set
% u = g for (x, y) on the border
% The border is the square [0,1] x [0,1]
u = @(x,y) sin(4*pi*(x + y)) + cos(4*pi*x*y);  % ground truth, which we wish to arrive at
f = @(x,y) -16*(2*sin(4*pi*(x + y)) + cos(4*pi*x*y)*(x^2 + y^2))*pi^2;
g = @(x,y) sin(4*pi*(x + y)) + cos(4*pi*x*y);  % border conditions


% set epsilon to small value, for error tolerance in loop 
epsilon = 1.0E-10;
% define omega. 2/3 is derived from plot of eigenvector analysis
omega = 2/3;

max_steps = 1000;

max_recursions = 5;
iterations_needed = zeros(max_recursions-1);

for L = 2:max_recursions
    % set mesh size
    m=2^L-1;

    % reset U to initial value
    U = ones(m*m,1);

    % Form the right-hand side
    [Xint,Yint,F] = constructRhs5(m,f,g); 
    
    fprintf('Doing L = %3d\n', L);
    % loop over approximation procedure
    for i=1:max_steps 
        R = F + Amult(U,m);  % how are we doing now? Lets print the normed residual
        fprintf('*** Outer iteration: %3d, rel. resid.: %e\n', ...
            i, norm(R,2)/norm(F,2));
        if(norm(R, 2)/norm(F, 2) < epsilon)
            break;
        end
        U = VCycle(U, F, L, omega, 3);  % enter recursive function that approximate solution
    end
    iterations_needed(L) = i;  % Save number of iterations needed to reach tolerance level
end

 
% Plotting figure with residuals
fig = figure;
bar(2:L, iterations_needed)
caption = sprintf("Iterations needed to get precision ", epsilon, "\n");
xlabel("Recursion depth")
ylabel("Iterations")
saveas(fig, "Figures/ex3b.png")

