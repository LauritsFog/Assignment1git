function [X,Y,U] = solvePoisson5(m,f,g)

    % Generating system matrix
    A = poisson5(m);

    % f = funs{1};
    % g = funs{2};

    % Constructing RHS
    [Xint,Yint,b] = constructRhs5(m,f,g);

    % Solving system (only interior nodes)
    Uint = A\b;

    h = 1/(m+1);

    % Generating boundary coordinates
    Xext = [linspace(h,1-h,m) ...
            linspace(h,1-h,m) ...
            zeros(1,m+2) ...
            ones(1,m+2)]';

    Yext = [zeros(1,m) ...
            ones(1,m) ...
            linspace(0,1,m+2) ...
            linspace(0,1,m+2)]';

    % Computing g at the boundary nodes
    Uext = arrayfun(g,Xext,Yext);

    U = [Uint;Uext];

    X = [Xint;Xext];
    Y = [Yint;Yext];
end