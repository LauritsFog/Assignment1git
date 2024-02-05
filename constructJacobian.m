function [J] = constructJacobian(U,h,epsilon)

    n = length(U);

    xdiff = [U(2:end);0]-[0;U(1:(end-1))];

    lowerDiag = epsilon/(h^2)-U/(2*h);
    middleDiag = -(2*epsilon)/(h^2)+xdiff/(2*h)-1;
    upperDiag = epsilon/(h^2)+U/(2*h);

    % Rearranging to make sure correct elements are placed in off-diagonals
    upperDiag = [0;upperDiag(1:(end-1))];
    lowerDiag = [lowerDiag(2:end);0];

    J = spdiags([lowerDiag middleDiag upperDiag],-1:1,n,n);

end