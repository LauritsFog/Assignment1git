% exact solution and RHS
u=@(x,y) exp(pi*x).*sin(pi*y)+0.5*(x.*y).^2;
f=@(x,y) x.^2+y.^2;
L = 6;
m=2^L-1;
U =zeros(m*m,1);
F =constructRhs5(m,f,u); %% TODO: Form the right-hand side
epsilon = 1.0E-10;
omega = 2/3;
for i=1:100
    R =F + Amult(U,m);
    fprintf('*** Outer iteration: %3d, rel. resid.: %e\n', ...
        i, norm(R,2)/norm(F,2));
    if(norm(R, 2)/norm(F, 2) < epsilon)
        break;
    end
    U = Vcycle(U, F, L, omega, 3);
    plotU(m,U);
    pause(.5);
end

function Unew=Vcycle(U, F, l, omega, nsmooth)
% Approximately solve: A*U = F
m = 2^l-1;
h = 1.0/(m+1);
l2m = log2(m+1);
assert(l2m==round(l2m));
%assert(length(U)==m*m);
if(l==1)
    % if we are at the coarsest level
    % TODO: solve the only remaining equation directly!
    disp("Hurraaaaa!!! vi er kommet til bunden i iterationen!!!")
    %size(U)
    %size(F)
    %l
    error_estimate = -.25 * F;
    %error_est_intplt = interpolate(error_estimate, 2^(l-1)-1);
    %U = U + error_est_intplt;
    %for i = 1:nsmooth
    %    U = smooth(U, omega, m, F);
    %end
    Unew = U + error_estimate 
else
    % 1. TODO: pre-smooth the error
    %    perform <nsmooth> Jacobi iterations
    for i = 1:nsmooth
        U = smooth(U, omega, m, F);
    end
    
    % 2. TODO: calculate the residual
    residual_ = F - Amult(U, m);
    size(residual_)
    % 3. TODO: coarsen the residual
    res_coarse = coarsen(residual_, m);
    res_coarse = res_coarse(:);
    % 4. recurse to Vcycle on a coarser grid
    % mc=(m-1)/2;
    e = zeros((m-1)/2 * (m-1)/2,1);
    %Ecoarse=Vcycle(zeros(mc*mc,1),omega,nsmooth,mc,-Rcoarse);
    l
    %m
    res_coarse_size = size(res_coarse)
    %e_size = size(e)
    U_size = size(U)
    error_estimate = Vcycle(e, res_coarse, l-1, omega, nsmooth);
    size(error_estimate)
    % 5. TODO: interpolate the error
    error_est_intplt = interpolate(error_estimate, 2^(l-1)-1);
    l
    m
    size(e)
    size(error_est_intplt)
    size(U)
    % 6. TODO: update the solution given the interpolated error

    U = U + error_est_intplt
    
    % 7. TODO: post-smooth the error
    %    perform <nsmooth> Jacobi iterations
    for i = 1:nsmooth
        U = smooth(U, omega, m, F);
    end
    Unew = U
end
end


function plotU(m,U)
h=1/(m+1);
x=linspace(1/h,1-1/h,m);
y=linspace(1/h,1-1/h,m);
[X,Y]=meshgrid(x,y);
surf(X, Y, reshape(U,[m,m])');
shading interp;
title('Computed solution');
xlabel('x');
ylabel('y');
zlabel('U');
end