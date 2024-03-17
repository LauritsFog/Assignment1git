function AU = Amult(U,m)
    AU = zeros(m,m);
    tmp = zeros(m+2, m+2);
    tmp(2:m+1, 2:m+1) = reshape(U, m, m);
    % læg sammen: venstre + over + under + højre
    AU(1:m, 1:m) = -4*tmp(2:m+1, 2:m+1) + tmp(2:m+1, 1:m+0) + tmp(1:m, 2:m+1) + tmp(3:m+2, 2:m+1) + tmp(2:m+1, 3:m+2) ;
    AU = -(m+1)^(2) * AU;
    AU = AU(:);
end