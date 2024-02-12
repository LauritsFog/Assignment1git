function Uiter = Newton(FdF,U0,h,epsilon,alpha,beta,n)
    
    Uiter = zeros(length(U0),n);

    % Initialization
    U = U0;
    [F, dF] = FdF(U,h,epsilon); 
    dU = -dF\F;  % This is the first step
 
    for i = 1:n
        U = U + dU;
        
        % Impose boundary conditions
        U(1) = alpha;
        U(end) = beta;

        Uiter(:,i) = U;
        [F, dF] = FdF(U,h,epsilon);
        dU = -dF\F;
    end

end