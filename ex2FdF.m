function [F, dF] = ex2FdF(U,h,epsilon)

    n = length(U);
    
    % Jacobian
    dF = constructJacobian(U,h,epsilon);
    
    % First order centered difference
    D1 = constructCenteredD1(n)./h;
    % Second order centered difference
    D2 = constructCenteredD2(n)./(h^2);
    
    % Compute F
    F = epsilon*D2*U+(diag(D1*U)-eye(n))*U;

end