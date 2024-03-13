function R = interpolate(Rc,m)

    tmp = zeros(m+2, m+2);
    tmp(2:m+1, 2:m+1) = reshape(Rc, m, m);
    
    R = zeros(2*m+1, 2*m+1);

    % This interpolation takes the average of two neighbors (horizontal or vertical) 
    % if there are two neighbors. Otherwise it takes the average of the four diagonals
    % x o x o x
    % o o o o o
    % x o x o x
    % o o o o o 
    % x o x o x

    % fill in original values
    R(2:2:2*m, 2:2:m*2) = tmp(2:m+1, 2:m+1);

    % fill in values with vertical neighbours
    R(1:2:2*m+1, 2:2:m*2) = (tmp(1:m+1, 2:m+1) + tmp(2:m+2, 2:m+1))/2;
    
    % fill in values with horizontal neighbours
    R(2:2:2*m, 1:2:m*2+1) = (tmp(2:m+1, 1:m+1) + tmp(2:m+1, 2:m+2))/2;
    
    % fill in values with diagonal neighbours
    R(1:2:2*m+1, 1:2:m*2+1) = (tmp(1:m+1, 1:m+1) + tmp(2:m+2, 1:m+1) + tmp(1:m+1, 2:m+2) + tmp(2:m+2, 2:m+2))/4;

    % squeeze the output to 1-d
    R=R(:);
end