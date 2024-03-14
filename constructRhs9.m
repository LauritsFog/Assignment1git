function [X,Y,F] = constructRhs9(m,f,g,flag)

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

            % Coordinates of current point
            x = i*h;
            y = j*h;

            X(k) = x;
            Y(k) = y;


            % Check if point is neighbouring exterior points and change rhs
            % accordingly

            if i == 1 && j == 1 % Bottom left point
                
                % Coordinates of points needed to calculate the special rhs
                % Upleft
                x1 = (i-1)*h;
                y1 = (j+1)*h;

                % Left
                x2 = (i-1)*h;
                y2 = j*h;

                % Downleft
                x3 = (i-1)*h;
                y3 = (j-1)*h;

                % Down
                x4 = i*h;
                y4 = (j-1)*h;

                % Downright
                x5 = (i+1)*h;
                y5 = (j-1)*h;

                
                F(k) = f(x,y) - (g(x1,y1) + 4*g(x2,y2) + g(x3,y3) + ...
                       4*g(x4,y4) + g(x5,y5))/(6*h^2);

            elseif i == m && j == m % Top right point
                
                % Downright
                x1 = (i+1)*h;
                y1 = (j-1)*h;

                % Right
                x2 = (i+1)*h;
                y2 = j*h;

                % Upright
                x3 = (i+1)*h;
                y3 = (j+1)*h;

                % Up
                x4 = i*h;
                y4 = (j+1)*h;

                % Upleft
                x5 = (i-1)*h;
                y5 = (j+1)*h;

                
                F(k) = f(x,y) - (g(x1,y1) + 4*g(x2,y2) + g(x3,y3) + ...
                       4*g(x4,y4) + g(x5,y5))/(6*h^2);

            elseif i == 1 && j == m % Top left point
                
                % Upleft
                x1 = (i-1)*h;
                y1 = (j+1)*h;

                % Left
                x2 = (i-1)*h;
                y2 = j*h;

                % Downleft
                x3 = (i-1)*h;
                y3 = (j-1)*h;

                % Up
                x4 = i*h;
                y4 = (j+1)*h;

                % Upright
                x5 = (i+1)*h;
                y5 = (j+1)*h;
                

                F(k) = f(x,y) - (g(x1,y1) + 4*g(x2,y2) + g(x3,y3) + ...
                       4*g(x4,y4) + g(x5,y5))/(6*h^2);
            
            elseif i == m && j == 1 % Bottom right point
                
                % Upright
                x1 = (i+1)*h;
                y1 = (j+1)*h;

                % Right
                x2 = (i+1)*h;
                y2 = j*h;

                % Downleft
                x3 = (i-1)*h;
                y3 = (j-1)*h;

                % Down
                x4 = i*h;
                y4 = (j-1)*h;

                % Downright
                x5 = (i+1)*h;
                y5 = (j-1)*h;

                
                F(k) = f(x,y) - (g(x1,y1) + 4*g(x2,y2) + g(x3,y3) + ...
                       4*g(x4,y4) + g(x5,y5))/(6*h^2);

            elseif i == 1 % Left side of points
                
                % Upleft
                x1 = (i-1)*h;
                y1 = (j+1)*h;

                % Left
                x2 = (i-1)*h;
                y2 = j*h;

                % Downleft
                x3 = (i-1)*h;
                y3 = (j-1)*h;


                F(k) = f(x,y) - (g(x1,y1) + 4*g(x2,y2) + g(x3,y3))/(6*h^2);

            elseif i == m % Right side of points
                
                % Downright
                x1 = (i+1)*h;
                y1 = (j-1)*h;

                % Right
                x2 = (i+1)*h;
                y2 = j*h;

                % Upright
                x3 = (i+1)*h;
                y3 = (j+1)*h;


                F(k) = f(x,y) - (g(x1,y1) + 4*g(x2,y2) + g(x3,y3))/(6*h^2);

            elseif j == 1 % Bottom side of points
                
                % Downright
                x1 = (i+1)*h;
                y1 = (j-1)*h;

                % Down
                x2 = i*h;
                y2 = (j-1)*h;

                % Downleft
                x3 = (i-1)*h;
                y3 = (j-1)*h;


                F(k) = f(x,y) - (g(x1,y1) + 4*g(x2,y2) + g(x3,y3))/(6*h^2);
                
            elseif j == m % Top side of points
                
                % Upright
                x1 = (i+1)*h;
                y1 = (j+1)*h;

                % Up
                x2 = i*h;
                y2 = (j+1)*h;

                % Upleft
                x3 = (i-1)*h;
                y3 = (j+1)*h;


                F(k) = f(x,y) - (g(x1,y1) + 4*g(x2,y2) + g(x3,y3))/(6*h^2);

            else % All other points
                
                F(k) = f(x,y);

            end
        end
    end

    % Iterator for calculating all points
    k = 0;

    % Allocate space for saving all points (including exterior)
    Xfull = zeros((m+2)^2,1);
    Yfull = zeros((m+2)^2,1);

    % Calculate coordinates
    for i = 1:(m+2)
        for j = 1:(m+2)

            k = k + 1;

            x = (i-1)*h;
            y = (j-1)*h;

            Xfull(k) = x;
            Yfull(k) = y;

        end
    end

    % Correction
    if flag % flag = true -> use correction

        % f evaluated at all nodes
        Ftemp = arrayfun(f,Xfull,Yfull);
    
        % Constructing system matrix for 5-point Laplacian that includes
        % exterior points
        e = ones(m+2,1);
        S = spdiags([e -2*e e], [-1 0 1], m+2, m+2);
        I = speye(m+2);
        A = kron(I,S)+kron(S,I);
        A = (1/h^2)*A;
    
        % Computing correction term - reshape to make it easier to remove
        % exterior points
        correctionTerm = reshape((h^2/12)*A*Ftemp,m+2,m+2);
    
        % Remove values for exterior points
        correctionTerm(:,1) = []; % First column
        correctionTerm(:,end) = []; % Last column
        correctionTerm(1,:) = []; % First row
        correctionTerm(end,:) = []; % Last row
    
        
        % Reshape to vector and add to right hand side
        F = F + correctionTerm(:);
    
    end


end