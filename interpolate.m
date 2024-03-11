function R = interpolate(Rc,m)

    tmp = zeros(m+2, m+2);
    tmp(2:m+1, 2:m+1) = reshape(Rc, m, m);
    
    R = zeros(2*m+1, 2*m+1);
    % fill in original values
    R(2:2:2*m, 2:2:m*2) = tmp(2:m+1, 2:m+1);
    % fill in values with vertical neighbors
    R(1:2:2*m+1, 2:2:m*2) = (tmp(1:m+1, 2:m+1) + tmp(2:m+2, 2:m+1))/2;
    
    % fill in values with horizontal neighbors
    R(2:2:2*m, 1:2:m*2+1) = (tmp(2:m+1, 1:m+1) + tmp(2:m+1, 2:m+2))/2;
    
    % fill in values with diagonal neighbors
    R(1:2:2*m+1, 1:2:m*2+1) = (tmp(1:m+1, 1:m+1) + tmp(2:m+2, 1:m+1) + tmp(1:m+1, 2:m+2) + tmp(2:m+2, 2:m+2))/4;
    R=R(:);
end