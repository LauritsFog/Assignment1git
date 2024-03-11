function Unew = smooth(U, omega, m, F)
    h = 1.0/(m+1);
    AU = -Amult(U, m);
    Unew = (1-omega)*U + omega/4*(AU*h^2+4*U) - (omega*h^2)/4*F;
    %Unew = (1-omega)*U + omega * (AU/4 + U) - omega*F/4*h^2;
    %Gu = (omega * h^2 * AU/4 + U)
    %c = - omega * h^2 * F/4
    %Unew = (1-omega) * U + omega * Gu + c
    %Unew = Gu + omega
    %Unew = (1-omega)*U + omega * ((AU - F*h^2)/2 + U);
    %AU = Amult(U, m);
    %Unew = (1-omega)*U + omega * (.5*AU*h^2 + U);
end