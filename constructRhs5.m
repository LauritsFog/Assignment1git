function F = constructRhs5(m,f,g)
    
    F = zeros(m^2,1);

    h = 1/(m+1);

    for i = 1:m
        for j = 1:m

            k = i+(j-1)*m;

            x = i*h;
            y = j*h;

            if i == 1 && j == 1

                x1 = (i-1)*h;
                y1 = j*h;

                x2 = i*h;
                y2 = (j-1)*h;
                
                F(k) = f(x,y) - (g(x1,y1) + g(x2,y2))/h^2;

            elseif i == m && j == m
                
                x1 = (i+1)*h;
                y1 = j*h;

                x2 = i*h;
                y2 = (j+1)*h;
                
                F(k) = f(x,y) - (g(x1,y1) + g(x2,y2))/h^2;

            elseif i == m
                
                x1 = (i+1)*h;
                y1 = j*h;

                F(k) = f(x,y) - (g(x1,y1))/h^2;

            elseif i == 1
                
                x1 = (i-1)*h;
                y1 = j*h;
    
                F(k) = f(x,y) - (g(x1,y1))/h^2;

            elseif j == 1
                
                x1 = i*h;
                y1 = (j-1)*h;

                F(k) = f(x,y) - (g(x1,y1))/h^2;
                
            elseif j == m
                
                x1 = i*h;
                y1 = (j+1)*h;

                F(k) = f(x,y) - (g(x1,y1))/h^2;

            else
                
                F(k) = f(x,y);

            end
        end
    end
end