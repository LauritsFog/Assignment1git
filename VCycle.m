function Unew=VCycle(U, F, l, omega, nsmooth)
% Approximately solve: A*U = F
m = 2^l-1;
h = 1.0/(m+1);
l2m = log2(m+1);
assert(l2m==round(l2m));
assert(length(U)==m*m);
if(l==1)  % if we are at the coarsest level
    % TODO: solve the only remaining equation directly!
    U_J = - 1/4*F*h^2;
    %Unew = (1-omega)*U + omega*U_J
    Unew = U_J;
else
    % 1. TODO: pre-smooth the error
    %    perform <nsmooth> Jacobi iterations
    for i = 1:nsmooth
        U = smooth(U, omega, m, F);
    end
    
    % 2. TODO: calculate the residual
    residual_ = F + Amult(U, m);
    %plotU(m,residual_);
    % 3. TODO: coarsen the residual
    res_coarse = coarsen2(residual_, m);
    res_coarse = res_coarse(:);
    
    % 4. recurse to Vcycle on a coarser grid
    e = zeros((m-1)/2 * (m-1)/2,1);
    error_estimate = VCycle(e, -res_coarse, l-1, omega, nsmooth);
    
    % 5. TODO: interpolate the error
    error_est_intplt = interpolate(error_estimate, (m-1)/2);
    
    % 6. TODO: update the solution given the interpolated error
    U = U - error_est_intplt;
    
    % 7. TODO: post-smooth the error
    for i = 1:nsmooth
        U = smooth(U, omega, m, F);
    end
    Unew = U;
end
end

