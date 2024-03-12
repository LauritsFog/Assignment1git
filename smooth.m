function Unew = smooth(U, omega, m, F)
    h = 1.0/(m+1);
    AU = -Amult(U, m);
    Unew = (1-omega)*U + omega/4*(AU*h^2+4*U) - (omega*h^2)/4*F;
    %Unew = omega/4*(AU*h^2+4*U) - (omega*h^2)/4*F;
    %Unew = (1-omega)*U + omega * (AU/4 + U) - omega*F/4*h^2;
    
    %Gu = (omega * h^2 * AU/4 + U)
    %c = - h^2 * F/4
    %Unew = Gu + omega    
    %Unew = (1-omega)*U + omega * (AU/4*h^2 + U) - F*h^2/4;
    %AU = Amult(U, m);
    %Unew = (1-omega)*U + omega * (.5*AU*h^2 + U);
    U_J = U+h^2*1/4*AU - h^2/4*F;
    Unew = (1-omega)*U + omega*U_J;
end