% exact solution and RHS
% u=@(x,y) exp(pi*x).*sin(pi*y)+0.5*(x.*y).^2;
% f=@(x,y) x.^2+y.^2;

% differential equation from exercise 2b
% the problem is on the form 
% nabla^2 u = u_xx + u_yy = f, for (x,y) in inner set
% u = g for (x, y) on the border

u = @(x,y) sin(4*pi*(x + y)) + cos(4*pi*x*y);  % ground truth, which we wish to arrive at
f = @(x,y) -16*(2*sin(4*pi*(x + y)) + cos(4*pi*x*y)*(x^2 + y^2))*pi^2;
g = @(x,y) sin(4*pi*(x + y)) + cos(4*pi*x*y);  % border conditions

% set recusion level and mesh size
L = 7;
m=2^L-1;

% Form the right-hand side
[Xint,Yint,F] = constructRhs5(m,f,g); 

% set epsilon to small value, for error tolerance in loop 
epsilon = 1.0E-10;

% reset U to initial value
U_0 = zeros(m*m,1);
U = U_0;

% define omega. 2/3 is derived from plot of eigenvector analysis
omega = 2/3;

% for debuggin purpose, we plot the true solution
%h=1/(m+1)
%x=linspace(h,1-h,m);
%y=linspace(h,1-h,m);
%[x,y]=meshgrid(x,y);
%z = sin(4*pi*(x + y)) + cos(4*pi*x*y)
%mesh(x,y,z);
%U=z(:)

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

%%

% Plotting figure with residuals
lnw = 1.5;
fig = figure;
semilogy(normalized_residual_hist,'-.',"LineWidth",lnw)
% hold on
% semilogy(1:i,1./(1:i).^2,'--',"LineWidth",lnw)
legend("Multigrid",'Fontsize',15,Location = "southeast")
caption = sprintf("Normed resdidual error, using multigrid \n");
grid on
xlabel("Iterations")
ylabel("Residual")
saveas(fig, "Figures/ex3_multigrid_convergence.png")

%%

fig = figure;
axes1 = axes('Parent',fig);
plotU(m,U);  % plot the solution 
view(axes1,[77.1 37.8113868613139]);
grid(axes1,'on');

saveas(fig, "Figures/ex3_multigrid_solution.png")






function plotU(m,U)
h=1/(m+1);
x=linspace(h,1-h,m);
y=linspace(h,1-h,m);
[X,Y]=meshgrid(x,y);
surf(X, Y, reshape(U,[m,m])');

% shading interp;
title('Computed solution');
xlabel('x');
ylabel('y');
zlabel('U');
end