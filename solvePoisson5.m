function [U] = solvePoisson5(m,f,g)

    A = poisson5(m);

    b = constructRhs5(m,f,g);

    U = A\b;

end