function [J] = constructJacobianNew(U,h,epsilon)

    % Constructs Jacobian matrix of the discretization used in Exercise 2a
    n = length(U)-2;
    
    J = zeros(n,n);

    % Iterating through every row
    for i = 1:n

        uidx = i+1;
        
        % Element in lower diagonal
        if i > 1
            J(i,i-1) = epsilon/h^2 - U(uidx)/(2*h);
        end
        
        % Element in diagonal
        J(i,i) = -2*epsilon/h^2 + (U(uidx+1)-U(uidx-1))/(2*h) - 1;
        
        % Element in upper diagonal
        if i < n
            J(i,i+1) = epsilon/h^2 + U(uidx)/(2*h);
        end

    end

end