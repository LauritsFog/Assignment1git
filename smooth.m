function Unew = smooth(U, omega, m, F)
    h = 1.0/(m+1);
    AU = -Amult(U, m);
    %Unew = (1-omega)*U + omega/4*(AU*h^2+4*U) - (omega*h^2)/4*F;    
    U_J = U + h^2*1/4*AU - h^2/4*F;
    Unew = (1-omega)*U + omega*U_J;
end