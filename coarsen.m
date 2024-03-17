function Rc = coarsen(R,m)
    
    % unsqueeze R into a 2d array
    R = reshape(R, m, m);
    
    % Add neighbours together according to the following rule:
    % 1 * upper left        2 * above           1 * upper right
    % 2 * left              4 * center          2 * right
    % 1 * lower left        2 * below           1 * lower right
    Rc = (R(1:2:m-2, 1:2:m-2)*1 + R(1:2:m-2, 2:2:m-1)*2 + R(1:2:m-2, 3:2:m)*1 ...
        + R(2:2:m-1, 1:2:m-2)*2 + R(2:2:m-1, 2:2:m-1)*4 + R(2:2:m-1, 3:2:m)*2 ...
        + R(3:2:m,   1:2:m-2)*1 + R(3:2:m,   2:2:m-1)*2 + R(3:2:m,   3:2:m)*1)/16;
end