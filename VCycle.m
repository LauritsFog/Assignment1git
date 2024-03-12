% exact solution and RHS
% u=@(x,y) exp(pi*x).*sin(pi*y)+0.5*(x.*y).^2;
% f=@(x,y) x.^2+y.^2;

% from exercise 2b
u = @(x,y) sin(4*pi*(x + y)) + cos(4*pi*x*y);
f = @(x,y) -16*(2*sin(4*pi*(x + y)) + cos(4*pi*x*y)*(x^2 + y^2))*pi^2;
g = @(x,y) sin(4*pi*(x + y)) + cos(4*pi*x*y);


L = 7;
m=2^L-1;
U = ones(m*m,1);
[Xint,Yint,F] = constructRhs5(m,f,g); %% TODO: Form the right-hand side
epsilon = 1.0E-10;
omega = 2/3;

%h=1/(m+1)
%x=linspace(h,1-h,m);
%y=linspace(h,1-h,m);
%[x,y]=meshgrid(x,y);
%z = sin(4*pi*(x + y)) + cos(4*pi*x*y)
%mesh(x,y,z);
%U=z(:)


% test smoother. Does it work?
if 1==2
    for i = 1:1000
        U = smooth(U, omega, m, F);
        if mod(i,10)==1
            plotU(m,U);
        end;
    end
end

for i=1:100
    R = F + Amult(U,m);
    %plotU(m,U);
    %plotU(m,R);
    fprintf('*** Outer iteration: %3d, rel. resid.: %e\n', ...
        i, norm(R,2)/norm(F,2));
    if(norm(R, 2)/norm(F, 2) < epsilon)
        break;
    end
    U = Vcycle(U, F, L, omega, 3);
    plotU(m,U);
    %pause(.5);
end

function Unew=Vcycle(U, F, l, omega, nsmooth)
% Approximately solve: A*U = F
m = 2^l-1;
h = 1.0/(m+1);
l2m = log2(m+1);
assert(l2m==round(l2m));
assert(length(U)==m*m);
if(l==1)
    % if we are at the coarsest level
    % TODO: solve the only remaining equation directly!
    disp("Hurraaaaa!!! vi er kommet til bunden i iterationen!!!")
    %error_estimate =  F;
    %Unew = U - error_estimate;
    %Unew = U - 1/4*F*h^2;

    %Unew = - 1/4*F*h^2;
    U_J = - 1/4*F*h^2;
    Unew = (1-omega)*U + omega*U_J
else
    % 1. TODO: pre-smooth the error
    %    perform <nsmooth> Jacobi iterations
    for i = 1:nsmooth
        U = smooth(U, omega, m, F);
        %plotU(m,U);
    end
    
    % 2. TODO: calculate the residual
    residual_ = F - Amult(U, m);
    %plotU(m,residual_);
    % 3. TODO: coarsen the residual
    res_coarse = coarsen2(residual_, m);
    res_coarse = res_coarse(:);
    
    % 4. recurse to Vcycle on a coarser grid
    e = zeros((m-1)/2 * (m-1)/2,1);
    error_estimate = Vcycle(e, res_coarse, l-1, omega, nsmooth);
    
    % 5. TODO: interpolate the error
    error_est_intplt = interpolate(error_estimate, (m-1)/2);
    
    % 6. TODO: update the solution given the interpolated error
    U = U + error_est_intplt;
    
    % 7. TODO: post-smooth the error
    %    perform <nsmooth> Jacobi iterations
    for i = 1:nsmooth
        U = smooth(U, omega, m, F);
    end
    Unew = U;
end

disp(size(Unew))
end


function plotU(m,U)
h=1/(m+1);
x=linspace(h,1-h,m);
y=linspace(h,1-h,m);
[X,Y]=meshgrid(x,y);
surf(X, Y, reshape(U,[m,m])');
shading interp;
title('Computed solution');
xlabel('x');
ylabel('y');
zlabel('U');
end