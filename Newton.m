function Uiter = Newton(FdF,U0,tol,maxit)
    
    Uiter = U0;

    % Initialization
    U = U0;
    [F, dF] = FdF(U); 
    
    dU = -dF\F;  % This is the first step

    iter = 1;
    err = inf;
 
    while err > tol && iter < maxit

        iter = iter + 1;

        % Only adding change to interior nodes
        U(2:(end-1)) = U(2:(end-1)) + dU;
        
        Uiter = [Uiter U];
        [F, dF] = FdF(U);
        dU = -dF\F;

        err = norm(U-Uiter(:,iter-1),'inf');

    end

end