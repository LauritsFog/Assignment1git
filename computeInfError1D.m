function [err] = computeInfError1D(ucoarse,ufine,xcoarse,xfine)

    % Linear interpolation
    ucoarseinterp = interp1(xcoarse,ucoarse,xfine);

    % Compute maximum error
    err = max(abs(ufine-ucoarseinterp));

end