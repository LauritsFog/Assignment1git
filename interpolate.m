function R = interpolate(Rc,m)

    Rc = reshape(Rc,(m-1)/2+2,(m-1)/2+2);

    R = interp2(Rc);

    R = R(:);

    % # interior nodes in fine grid
    mf = 2*m + 1;

    for ci = 1:mf
        for cj = 1:mf

            

        end
    end

end