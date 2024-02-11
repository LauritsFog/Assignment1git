function [dudt] = ex2odefun(x,u,epsilon)

    % We write the ODE as
    % u1' = u2
    % u2' = -u1(u2-1)/epsilon

    u1 = u(1);
    u2 = u(2);
    
    % Compute F
    dudt = [u2;
            -(u1*(u2-1))/epsilon];

end