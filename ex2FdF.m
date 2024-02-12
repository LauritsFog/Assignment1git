function [F, dF] = ex2FdF(U,h,epsilon)

    n = length(U)-2;
    
    % Jacobian
    dF = constructJacobianNew(U,h,epsilon);
    
    % % First order centered difference
    % D1 = constructCenteredD1(n+2)./h;
    % % Second order centered difference
    % D2 = constructCenteredD2(n+2)./(h^2);
    % 
    % % Compute F
    % Falt = epsilon.*D2*U+(diag(D1*U)-eye(n+2))*U;
    
    F = zeros(n,1);

    for i = 1:n

        uidx = i+1;

        F(i) = epsilon*(U(uidx-1) - 2*U(uidx) + U(uidx+1))/h^2 + ...
               U(uidx)*((U(uidx+1) - U(uidx-1))/(2*h) - 1);
    end
    
end