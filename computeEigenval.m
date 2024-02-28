function lambda = computeEigenval(m,omega)

    lambda = zeros(m,m);

    h = 1/(m+1);

    for p = 1:m
        for q = 1:m
            lambda(p,q) = (omega/2)*((cos(p*pi*h) - 1) + ...
                          (cos(q*pi*h) - 1)) + 1;

        end
    end

end