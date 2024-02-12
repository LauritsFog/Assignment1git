function [J] = constructJacobianNew(U,h,epsilon)

    n = length(U)-2;
    
    J = zeros(n,n);

    for i = 1:n

        uidx = i+1;
        
        if i > 1
            J(i,i-1) = epsilon/h^2 - U(uidx)/(2*h);
        end
        
        J(i,i) = -2*epsilon/h^2 + (U(uidx+1)-U(uidx-1))/(2*h) - 1;
        
        if i < n
            J(i,i+1) = epsilon/h^2 + U(uidx)/(2*h);
        end

    end

end