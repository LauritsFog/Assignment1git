function [A] = constructCenteredD1(n)

    e = ones(n,1);
    A = spdiags([-1/2*e 0*e 1/2*e],-1:1,n,n);
    
end