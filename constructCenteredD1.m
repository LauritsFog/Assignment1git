function [A] = constructCenteredD1(n)

    e = ones(n,1);
    A = spdiags([-1/2*e 0*e 1/2*e],-1:1,n,n);

    % % Forward differencing in the beginning
    % A(1,1:3) = [-3/2 2 -1/2];
    % 
    % % Backward differencing in the beginning
    % A(end,(end-2):end) = [1/2 -2 3/2];

    % Taken from https://en.wikipedia.org/wiki/Finite_difference_coefficient
end