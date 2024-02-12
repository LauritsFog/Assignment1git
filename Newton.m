function Uiter = Newton(FdF,U0,h,epsilon,tol,maxit)
    
    Uiter = U0;

    % Initialization
    U = U0;
    [F, dF] = FdF(U,h,epsilon); 
    
    dU = -dF\F;  % This is the first step

    iter = 1;
    err = inf;
 
    while err > tol && iter < maxit

        iter = iter + 1;

        U(2:(end-1)) = U(2:(end-1)) + dU;
        
        Uiter = [Uiter U];
        [F, dF] = FdF(U,h,epsilon);
        dU = -dF\F;

        err = norm(U-Uiter(:,iter-1),'inf');

    end

end