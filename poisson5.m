function A = poisson5(m)
    % Constructs 5-point 2D A matrix for the Poisson equation.

    e = ones(m,1);
    S = spdiags([e -2*e e], [-1 0 1], m, m);
    I = speye(m);
    A = kron(I,S)+kron(S,I);
    A=(m+1)^2*A;
end