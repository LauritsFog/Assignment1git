function R = interpolate(Rc,m)

    Rc = reshape(Rc,(m-1)/2+2,(m-1)/2+2);

    R = interp2(Rc);

    R = R(:);

end