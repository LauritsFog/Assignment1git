function Rc = coarsen(R,m)
    % Assume
    % m = 2^k-1

    % # interior nodes of coarse grid
    mc = (m-1)/2;

    % Coarse grid
    Rc = zeros((m-1)/2,(m-1)/2);

    % Gather stencil
    FW = 1/16*[1 2 1;2 4 2;1 2 1];

    % Coarse indicies
    for ci = 1:mc
        for cj = 1:mc

            % Fine indices
            fi = ci + (ci-1);
            fj = cj + (cj-1);

            % Gather operation using full weight stencil
            for i = -1:1
                for j = -1:1
                    
                    Rc(ci,cj) = Rc(ci,cj) + FW(i+2,j+2)*R(fi+i,fj+j);

                end
            end

        end
    end

end