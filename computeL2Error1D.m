function [err] = computeL2Error1D(ucoarse,ufine,h)

    % Number of nodes in coarse sol
    N = length(ucoarse);
    
    % N-1: Number of elements
    err = zeros(N-1,1);

    for i = 1:(N-1)

        u1 = ucoarse(i); % First node of element i in coarse mesh
        u2 = ufine(2*i); % Middle node of element i in fine mesh
        u3 = ucoarse(i+1); % Second node of element i in coarse mesh
        
        % Compute error
        err(i) = sqrt(h/12)*abs(u1-2*u2+u3);
    end

end