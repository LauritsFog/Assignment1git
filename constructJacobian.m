function [J] = constructJacobian(U,h,epsilon)

    n = length(U);

    xdiff = [U(2:end);0]-[0;U(1:(end-1))];

    lowerDiag = epsilon/(h^2)-U./(2*h);
    middleDiag = -(2*epsilon)/(h^2)+xdiff./(2*h)-1;
    upperDiag = epsilon/(h^2)+U./(2*h);

    % Rearranging to make sure correct elements are placed in off-diagonals
    upperDiag = [upperDiag(end);upperDiag(1:(end-1))];
    lowerDiag = [lowerDiag(2:end);lowerDiag(1)];

    J = spdiags([lowerDiag middleDiag upperDiag],-1:1,n,n);

    % Forward and backward differencing at first and last node
    u1 = U(1);
    u2 = U(2);
    u3 = U(3);

    J(1,1:4) = [2*epsilon/h^2 - (3*u2)/(2*h) ...
                -5*epsilon/h^2 + (-(3*u1)/2 + 2*u2 - u3/2)/h - 1 + 2*u2/h ...
                4*epsilon/h^2 - u2/(2*h) ...
                -epsilon/h^2];
    
    u1 = U(n);
    u2 = U(n-1);
    u3 = U(n-2);
    
    J(n,(end-3):end) = [-epsilon/h^2 ...
                        4*epsilon/h^2 + u2/(2*h) ...
                        -5*epsilon/h^2 + ((3*u1)/2 - 2*u2 + u3/2)/h - 1 - 2*u2/h ...
                        2*epsilon/h^2 + (3*u2)/(2*h)];
    
end