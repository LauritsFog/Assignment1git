function Rc = coarsen(R,m)
    % m = 2^k-1

    R = reshape(R,m+2,m+2);

    % Take every other row and column. 
    R = R(1:2:(m+2),1:2:(m+2));

    Rc = R(:);

end