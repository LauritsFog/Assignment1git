function [A] = constructCenteredD2(n)

    e = ones(n,1);
    A = spdiags([e -2*e e],-1:1,n,n);
    
    % Forward differencing in the beginning
    A(1,1:4) = [2 -5 4 -1];
    
    % Backward differencing in the beginning
    A(end,(end-3):end) = [-1 4 -5 2];

    % Taken from https://en.wikipedia.org/wiki/Finite_difference_coefficient
end