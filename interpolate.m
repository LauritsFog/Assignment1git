function R = interpolate(Rc,m)

    if m>1
        Rc = reshape(Rc,(m-1)/2+2,(m-1)/2+2);
        R = interp2(interp2(Rc));
        R = R(:);
    else
        R = ones(3,3)*Rc;
        R=R(:);
    end
end