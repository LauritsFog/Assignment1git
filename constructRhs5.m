function [X,Y,F] = constructRhs5(m,f,g)

    % Construct empty vectors to store mesh points and rhs
    X = zeros(m^2,1);
    Y = zeros(m^2,1);
    
    F = zeros(m^2,1);

    % Mesh size
    h = 1/(m+1);

    % Simpler to increment k than calculating in each loop
    k = 0;

    % Go through all interior mesh-points
    for i = 1:m
        for j = 1:m

            k = k + 1;

            % x and y coordinates of current point
            x = i*h;
            y = j*h;

            X(k) = x;
            Y(k) = y;

            
            % Check if point is neighbouring exterior points and change rhs
            % accordingly

            if i == 1 && j == 1 % Bottom left point

                % Coordinates of points needed to calculate the special rhs
                % Left
                x1 = (i-1)*h;
                y1 = j*h;

                % Down
                x2 = i*h;
                y2 = (j-1)*h;
                

                F(k) = f(x,y) - (g(x1,y1) + g(x2,y2))/h^2;

            elseif i == m && j == m % Top right point
                
                % Right
                x1 = (i+1)*h;
                y1 = j*h;

                % Up
                x2 = i*h;
                y2 = (j+1)*h;
                

                F(k) = f(x,y) - (g(x1,y1) + g(x2,y2))/h^2;

            elseif i == 1 && j == m % Top left
                
                % Left
                x1 = (i-1)*h;
                y1 = j*h;

                % Up
                x2 = i*h;
                y2 = (j+1)*h;
                

                F(k) = f(x,y) - (g(x1,y1) + g(x2,y2))/h^2;
            
            elseif i == m && j == 1 % Bottom right point
                
                % Right
                x1 = (i+1)*h;
                y1 = j*h;

                % Down
                x2 = i*h;
                y2 = (j-1)*h;
                
                F(k) = f(x,y) - (g(x1,y1) + g(x2,y2))/h^2;

            elseif i == 1 % Left side of grid
                
                % Left
                x1 = (i-1)*h;
                y1 = j*h;


                F(k) = f(x,y) - (g(x1,y1))/h^2;

            elseif i == m % Right side of grid
                
                % Right
                x1 = (i+1)*h;
                y1 = j*h;

    
                F(k) = f(x,y) - (g(x1,y1))/h^2;

            elseif j == 1 % Bottom side of grid
                
                % Down
                x1 = i*h;
                y1 = (j-1)*h;

                F(k) = f(x,y) - (g(x1,y1))/h^2;
                
            elseif j == m % Top side of grid
                
                % Up
                x1 = i*h;
                y1 = (j+1)*h;


                F(k) = f(x,y) - (g(x1,y1))/h^2;

            else % All other points
                
                F(k) = f(x,y);

            end
        end
    end
end