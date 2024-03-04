function Unew = smooth(U,omega,m,F)

    AU = -Amult(U,m);

    Unew = (1-omega)*U + omega/4*(AU+4*U) - (omega*h^2)/4*F;

end