function Rc = coarsen(R,m)
    R = reshape(R, m, m);
    % # interior nodes of coarse grid
    mc = (m-1)/2;
    % Coarse grid
    Rc = zeros(mc,mc);
    % upper left, above, upper right
    % left,  center, right
    % lower left, below, lower right
    Rc = (R(1:2:m-2, 1:2:m-2)*1 + R(1:2:m-2, 2:2:m-1)*2 + R(1:2:m-2, 3:2:m)*1 ...
        + R(2:2:m-1, 1:2:m-2)*2 + R(2:2:m-1, 2:2:m-1)*4 + R(2:2:m-1, 3:2:m)*2 ...
        + R(3:2:m,   1:2:m-2)*1 + R(3:2:m,   2:2:m-1)*2 + R(3:2:m,   3:2:m)*1)/16;
end