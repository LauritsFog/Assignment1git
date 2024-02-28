function AU = Amult(U,m)
    
    AU = zeros(m^2,1);

    U = reshape(U,m,m);
    
    k = 0;

    for i = 1:m
        for j = 1:m

            k = k + 1;

            if i == 1 && j == 1 % Bottom left

                AU(k) = -4*U(i,j) + U(i+1,j) + U(i,j+1);

            elseif i == m && j == m % Top right
                
                AU(k) = -4*U(i,j) + U(i-1,j) + U(i,j-1);

            elseif i == 1 && j == m % Top left
                
                AU(k) = -4*U(i,j) + U(i+1,j) + U(i,j-1);

            elseif i == m && j == 1 % Bottom right
                
                AU(k) = -4*U(i,j) + U(i-1,j) + U(i,j+1);

            elseif i == 1 % Left
                
                AU(k) = -4*U(i,j) + U(i+1,j) + U(i,j-1)+ U(i,j+1);

            elseif i == m % Right
                
                AU(k) = -4*U(i,j) + U(i-1,j) + U(i,j-1)+ U(i,j+1);

            elseif j == 1 % Bottom
                
                AU(k) = -4*U(i,j) + U(1,j+1) + U(i-1,j)+ U(i+1,j);
                
            elseif j == m % Top
                
                AU(k) = -4*U(i,j) + U(1,j-1) + U(i-1,j)+ U(i+1,j);

            else
                
                AU(k) = -4*U(i,j) + U(1,j+1) + U(1,j-1) + U(i-1,j)+ U(i+1,j);

            end
        end
    end
    
    AU = (m+1)^2*AU;

end